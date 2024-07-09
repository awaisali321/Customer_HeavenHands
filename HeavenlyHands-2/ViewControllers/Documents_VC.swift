//
//  ViewController.swift
//  HeavenlyHands-2
//
//  Created by Abdul Naffay on 10/01/2024.
//

import UIKit

class Documents_VC: UIViewController {
    @IBOutlet weak var nodatafound: UIView!
    @IBOutlet weak var DocumentsTbl:UITableView!
    var DocumentsNamesArray = [String]()
    var DatesArray = [String]()
    var TimeArray = [String]()
    var DocumentsmodelArray:DocumentsModel? {
        didSet{
            if(DocumentsmodelArray?.data?.count ?? 0 > 0){
                nodatafound.isHidden = true
            }else{
                nodatafound.isHidden = false
            }
            
            DocumentsTbl.reloadData()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
     
        self.DocumentsApi()
    }
    @objc func DocumentsViewBtn(sender: UIButton){
        let data = DocumentsmodelArray?.data?[sender.tag]
                
        var filePath = data?.url ?? ""
        let prefix = "public/"

        if filePath.hasPrefix(prefix) {
            filePath = filePath.replacingOccurrences(of: prefix, with: "")
        }

        print(filePath)
        
      
        let someText:String = ""
        let objectsToShare:URL = URL(string: AppConstants.API.imageurl.absoluteString + (filePath))!
        
      
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let destination = storyboard.instantiateViewController(withIdentifier: "Documents_View_VC") as! Documents_View_VC

        destination.PathLbl = objectsToShare.absoluteString
        
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
        cell.DateLbl.text = self.setdate(setdate: data?.createdAt ?? "", format: "dd-MM-yyyy")
     
        cell.TimeLbl.text = self.setdate(setdate: data?.createdAt ?? "", format: "hh:mm a")
        
        
        
        cell.ViewDocumentsBtn.tag = indexPath.row
        cell.ViewDocumentsBtn.addTarget(self, action: #selector(DocumentsViewBtn(sender:)), for: .touchUpInside)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
        
    }
    func setdate(setdate:String,format:String)->String{
        
        
        
        
  
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        formatter.locale = Locale(identifier: "en_US_POSIX")
       
        
//
//        let formatter = DateFormatter()
//
//        formatter.dateFormat = "yyyy-MM-ddTHH:mm:ss.SSS ZZZZ"
        let result = formatter.date(from: setdate) ?? Date()
        
        let formatter2 = DateFormatter()
        formatter2.dateFormat = format
        let result3 = formatter2.string(from: result)
        

        return result3
        
    }
    
}
