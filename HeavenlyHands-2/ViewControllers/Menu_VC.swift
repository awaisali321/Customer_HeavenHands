//
//  Menu_VC.swift
//  HeavenlyHands-2
//
//  Created by Abdul Naffay on 10/01/2024.
//

import UIKit

class Menu_VC: UIViewController {
    @IBOutlet weak var MenuTbl:UITableView!
    var MenuItems = [String]()
    var MenuImages = [String]()
    var LogoutModel:LogOutModel? = nil
   
    let kMainStoryBoard =   UIStoryboard(name: "Main", bundle: nil)
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        MenuTbl.delegate = self
        MenuTbl.dataSource = self
        
        MenuItems = ["Dashboard","Reports","Documents","Tasks","Appointments","Chat"]
        MenuImages = ["dashboard-icon","google-docs-icon","document-icon","list_icon","calendar-icon","chat-icon"]
        
        
//        self.view.backgroundColor = .gray
        
        
        
    }
    private  func LogOutApi() {
        APIServices.LogOutApi() {(result) in
            switch result{
            case .success(let response):
                self.LogoutModel = response
               
                appdelegate.gotoSignInVc()
                self.view.makeToast("Successfully LogOut")

            case .failure(let error):
                print(error)
                if(error == "Response status code was unacceptable: 500."){
                    
                    appdelegate.gotoSignInVc()
                }
            }
        }
    }
    @IBAction func btn_open_menu(_ Sender:Any){
        self.sideMenuController?.toggle()
        
    }
    @IBAction func Profile_Btn(_ Sender:Any){
//        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
//        let destination = storyboard.instantiateViewController(withIdentifier: "Profile_VC") as! Profile_VC
//        navigationController?.pushViewController(destination, animated: true)
//        dismiss(animated: true, completion: nil)
        let myViewController = kMainStoryBoard.instantiateViewController(withIdentifier: "Profile_VC") as? Profile_VC
        
        sideMenuController?.embed(centerViewController: myViewController!)
        

    }
    @IBAction func LogOutBtn(_ Sender:Any){
        appdelegate.gotoSignInVc()
        self.LogOutApi()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension Menu_VC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MenuItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = MenuTbl.dequeueReusableCell(withIdentifier: "MenuVC_Cell", for: indexPath)as!
            MenuVC_Cell
            cell.MenuItemsLbl.text = MenuItems[indexPath.row]
            cell.MenuItemsIMGView.image = UIImage(named: MenuImages[indexPath.row])
            
            return cell
     
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! MenuVC_Cell
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
            let dict = MenuItems[indexPath.row]
        
            if (dict == "Dashboard"){
                let myViewController = kMainStoryBoard.instantiateViewController(withIdentifier: "DashBoard_VC") as? DashBoard_VC
                
                sideMenuController?.embed(centerViewController: myViewController!)
        
        }
        else if (dict == "Reports"){
            let myViewController = kMainStoryBoard.instantiateViewController(withIdentifier: "Reports_VC") as? Reports_VC
            sideMenuController?.embed(centerViewController: myViewController!)
            
        }else if (dict == "Documents"){
            let myViewController = kMainStoryBoard.instantiateViewController(withIdentifier: "Documents_VC") as? Documents_VC
            sideMenuController?.embed(centerViewController: myViewController!)
            
        }else if (dict == "Tasks"){
            let myViewController = kMainStoryBoard.instantiateViewController(withIdentifier: "Tasks_VC") as? Tasks_VC
            sideMenuController?.embed(centerViewController: myViewController!)
            
        }else if (dict == "Appointments"){
            let myViewController = kMainStoryBoard.instantiateViewController(withIdentifier: "Appointments_VC") as? Appointments_VC
            sideMenuController?.embed(centerViewController: myViewController!)
            
        }else if (dict == "Chat"){
            let myViewController = kMainStoryBoard.instantiateViewController(withIdentifier: "Chats_VC") as? Chats_VC
            sideMenuController?.embed(centerViewController: myViewController!)
            
        }else{
            UserDefaults.standard.set(false, forKey: "islogin")
            UserDefaults.standard.set("", forKey: "Username")
            UserDefaults.standard.set("", forKey: "password")
               
                appdelegate.gotoSignInVc()

        }
    }

 
}


   
