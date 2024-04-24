//
//  ViewController.swift
//  HeavenlyHands-2
//
//  Created by Abdul Naffay on 10/01/2024.
//

import UIKit

class Documents_VC: UIViewController {
    @IBOutlet weak var DocumentsTbl:UITableView!
    var DocumentsNamesArray = [String]()
    var DatesArray = [String]()
    var TimeArray = [String]()
    var DocumentsmodelArray:DocumentsModel? {
        didSet{
            DocumentsTbl.reloadData()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        DocumentsNamesArray = ["Documents 01","Documents 02","Documents 03","Documents 04"]
        DatesArray = ["07-01-2024","08-01-2024","09-01-2024","10-01-2024"]
        TimeArray = ["11:00 am","12:00 pm","01:00 pm","03:00 pm"]
        
        self.DocumentsApi()
    }
    @objc func DocumentsViewBtn(sender: UIButton){
        let data = DocumentsmodelArray?.data?[sender.tag]
                
                let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                let destination = storyboard.instantiateViewController(withIdentifier: "Documents_View_VC") as! Documents_View_VC
                destination.PathLbl = data?.url ?? ""
                
                navigationController?.pushViewController(destination, animated: true)
                dismiss(animated: true, completion: nil)
        
    }
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        DocumentsTbl.dataSource = self
        DocumentsTbl.delegate = self
    }
    @IBAction func NotificationBtn(_ Sender:Any){
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let destination = storyboard.instantiateViewController(withIdentifier: "Notifications_VC") as! Notifications_VC
        navigationController?.pushViewController(destination, animated: true)
        dismiss(animated: true, completion: nil)
        
    }
    @IBAction func btn_open_menu(_ Sender:Any){
        self.sideMenuController?.toggle()
        
    }
    private  func DocumentsApi() {
        APIServices.DocumentsApi() {(result) in
            switch result{
            case .success(let response):
                self.DocumentsmodelArray = response
                
                if(response.data?.isEmpty == true){
                    self.view.makeToast("No Data Found")
                }else{
                    
                }
                
            case .failure(let error):
                if(error == "Response status code was unacceptable: 500."){
                    
                    appdelegate.gotoSignInVc()
                    self.view.makeToast("LogIn Session Expired")
                }
                
                
            }
        }
    }
}
extension Documents_VC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DocumentsmodelArray?.data?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = DocumentsTbl.dequeueReusableCell(withIdentifier: "Documents_Cell", for: indexPath)as!
        Documents_Cell
        let data = DocumentsmodelArray?.data?[indexPath.row]
        cell.DocumentNameLbl.text = data?.type
        cell.DateLbl.text = data?.createdAt?.pToDate()?.getFormattedDate(format: "dd-MM-yyyy")
        cell.TimeLbl.text = data?.createdAt?.pToDate()?.currentTimeStamp
        
        cell.ViewDocumentsBtn.tag = indexPath.row
        cell.ViewDocumentsBtn.addTarget(self, action: #selector(DocumentsViewBtn(sender:)), for: .touchUpInside)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
        
    }
    
}
