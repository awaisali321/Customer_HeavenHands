//
//  DashBoard_VC.swift
//  HeavenlyHands-2
//
//  Created by Abdul Naffay on 10/01/2024.
//

import UIKit

class DashBoard_VC: UIViewController {

    
    @IBOutlet weak var DashboardCollectionView:UICollectionView!
    @IBOutlet weak var DateLbl:UILabel!
    
    let kMainStoryBoard =   UIStoryboard(name: "Main", bundle: nil)
    var tableData: [String] = ["Reports", "Documents", "Tasks","Appointments"]
       var tableImages: [String] = ["report_icon", "google-docs_2", "report_icon", "calendar-clock"]
    
//    var tableResults: [String] = ["No New Reports", "No New Reports", "3 New Tasks", "No Appointments"]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"

        DateLbl.text = dateFormatter.string(from: Date())
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        DashboardCollectionView.delegate = self
        DashboardCollectionView.dataSource = self
       
    }
    @IBAction func btn_open_menu(_ Sender:Any){
        self.sideMenuController?.toggle()
        

    }
    @IBAction func NotificationBtn(_ Sender:Any){
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let destination = storyboard.instantiateViewController(withIdentifier: "Notifications_VC") as! Notifications_VC
        navigationController?.pushViewController(destination, animated: true)
        dismiss(animated: true, completion: nil)

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
extension DashBoard_VC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tableData.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell = DashboardCollectionView.dequeueReusableCell(withReuseIdentifier: "DashboardColection_Cell", for: indexPath)as! DashboardColection_Cell
        cell.dashboardItemsNamesLbl.text = tableData[indexPath.row]
//        cell.dashboardItemsDataLbl.text = tableResults[indexPath.row]
        cell.dashboardItemsImages.image = UIImage(named: tableImages[indexPath.row])
//        if (indexPath.row == 0){
//            cell.dashboardItemsDataLbl.text = " New Reports"
//        }else if(indexPath.row == 1){
//            cell.dashboardItemsDataLbl.text = " New Documents"
//        }else if(indexPath.row == 2){
//            cell.dashboardItemsDataLbl.text = " New Tasks"
//        }else {
//            cell.dashboardItemsDataLbl.text = " New Appointments"
//        }
        
//        cell.dashboardItemsImages.tintColor = .themeColor
        
      
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout:
                UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return  CGSize(width: (DashboardCollectionView.frame.size.width) / 2 - 5 , height: 140)
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
            let dict = tableData[indexPath.row]
        
        if(dict == "Reports"){
            let myViewController = kMainStoryBoard.instantiateViewController(withIdentifier: "Reports_VC") as? Reports_VC
            
            sideMenuController?.embed(centerViewController: myViewController!)
        }else if(dict == "Documents"){
            let myViewController = kMainStoryBoard.instantiateViewController(withIdentifier: "Documents_VC") as? Documents_VC
            sideMenuController?.embed(centerViewController: myViewController!)
        }else if(dict == "Tasks"){
            let myViewController = kMainStoryBoard.instantiateViewController(withIdentifier: "Tasks_VC") as? Tasks_VC
            sideMenuController?.embed(centerViewController: myViewController!)
        }else if(dict == "Appointments"){
            let myViewController = kMainStoryBoard.instantiateViewController(withIdentifier: "Appointments_VC") as? Appointments_VC
            sideMenuController?.embed(centerViewController: myViewController!)
        }
    }
    
}
