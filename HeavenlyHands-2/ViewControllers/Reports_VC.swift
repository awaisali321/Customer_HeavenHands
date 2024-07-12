//
//  ReportsVC.swift
//  HeavenlyHands-2
//
//  Created by Abdul Naffay on 10/01/2024.
//

import UIKit
import EzPopup
import Kingfisher
import Alamofire
import SwiftyJSON

class Reports_VC: UIViewController {
    @IBOutlet weak var ReportsTbl:UITableView!
    @IBOutlet weak var nodatafound: UIView!
   
  
    var DocumentsNamesArray = [String]()
    var DatesArray = [String]()
    var TimeArray = [String]()
    var ReportsmodelArray:ReportsModel? {
        didSet{
            if(ReportsmodelArray?.data?.count ?? 0 > 0){
                nodatafound.isHidden = true
            }else{
                nodatafound.isHidden = false
            }
            
            
            
            ReportsTbl.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
      
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        ReportsTbl.dataSource = self
        ReportsTbl.delegate = self
        self.ReportsApi()
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
    @objc func PdfDownloadBtn(sender: UIButton){
        let data = ReportsmodelArray?.data?[sender.tag]
        let pickerVC_self = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "signatureVC") as? signatureVC
        pickerVC_self?.Tripid = "\(data?.id ?? 0)"
        pickerVC_self?.type = "P"
        pickerVC_self?.delegate = self
        let popupVC = PopupViewController(contentController: pickerVC_self!, popupWidth: 310,popupHeight: 480)
        popupVC.cornerRadius = 10
        present(popupVC, animated: true, completion: nil)
    }
    @objc func ReportsViewBtn(sender: UIButton){
        let data = ReportsmodelArray?.data?[sender.tag]
        if (data?.html?.isEmpty == false){
            let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            let destination = storyboard.instantiateViewController(withIdentifier: "ReportsView_VC") as! ReportsView_VC

            destination.PathLbl = data?.html ?? ""
            destination.iscome = "report"
            destination.datamdl = data
            navigationController?.pushViewController(destination, animated: true)
            dismiss(animated: true, completion: nil)
            
        }else{
            self.view.makeToast("Reports Are Not Ready Yet")
            
        }
    }
    
  

    private  func ReportsApi() {
        APIServices.ReportsApi() {(result) in
            switch result{
            case .success(let response):
                self.ReportsmodelArray = response
  
                
                
                 
                

            case .failure(let error):
                if(error == "Response status code was unacceptable: 500."){
                    
                    appdelegate.gotoSignInVc()
                    self.view.makeToast("LogIn Session Expired")
                }
       
                
            }
        }
    }
    
    private func uploadImage(reportid: String, image: Data) {
           APIServices.uploadImage(reportid: reportid, image: image) { (result) in
               switch result {
               case .success(let response):
                   self.ReportsApi()
                   // Handle success response
                  self.view.makeToast("Image uploaded successfully")
                   
               case .failure(let error):
                   print("Image upload failed with error: \(error)")
                   if error == "Response status code was unacceptable: 500." {
                       appdelegate.gotoSignInVc()
                       self.view.makeToast("LogIn Session Expired")
                   } else {
                       self.ReportsApi()
                       // Handle success response
                      self.view.makeToast("Image uploaded successfully")
                   }
               }
           }
       }
   }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


extension Reports_VC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return ReportsmodelArray?.data?.count ?? 0
        
    }
        
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ReportsTbl.dequeueReusableCell(withIdentifier: "Reports_Cell", for: indexPath)as!
        Reports_Cell
        let data = ReportsmodelArray?.data?[indexPath.row]
        cell.ReportNameLbl.text = data?.type
        cell.PdfDownloadBtn.tag = indexPath.row
        cell.PdfDownloadBtn.addTarget(self, action: #selector(PdfDownloadBtn(sender:)), for: .touchUpInside)
        cell.ViewFileBtn.tag = indexPath.row
        cell.ViewFileBtn.addTarget(self, action: #selector(ReportsViewBtn(sender:)), for: .touchUpInside)
//        cell.DateLbl.text = data?.createdAt?.pToDate()?.getFormattedDate(format: "dd-MM-yyyy")
//        cell.TimeLbl.text = data?.createdAt?.pToDate()?.currentTimeStamp
        cell.DateLbl.text = self.setdate(setdate: data?.createdAt ?? "", format: "dd-MM-yyyy")
     
        cell.TimeLbl.text = self.setdate(setdate: data?.createdAt ?? "", format: "hh:mm a")
        
        cell.eyeview.isHidden = false
      
        if(data?.patient_signature != nil || data?.type == "INDIVIDUAL SERVICE REPORT (ISR)"){
           
            cell.signatureview.isHidden = true
        }else{
           
            cell.signatureview.isHidden = false
        }
        
        
        
    
        return cell
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let data = ReportsmodelArray?.data?[indexPath.row]
        if(data?.isApproved == 1){
            return 60
        }else{
            return 0
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = ReportsmodelArray?.data?[indexPath.row]
        if (data?.html?.isEmpty == false){
            let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            let destination = storyboard.instantiateViewController(withIdentifier: "ReportsView_VC") as! ReportsView_VC
        
            destination.PathLbl = data?.html ?? ""
            destination.iscome = "report"
            destination.datamdl = data
            navigationController?.pushViewController(destination, animated: true)
            dismiss(animated: true, completion: nil)
            
        }else{
            self.view.makeToast("Reports Are Not Ready Yet")
            
        }
    }
    func loadImageFromDiskWith(fileName: String) -> UIImage? {
        
        let documentDirectory = FileManager.SearchPathDirectory.documentDirectory
        
        let userDomainMask = FileManager.SearchPathDomainMask.userDomainMask
        let paths = NSSearchPathForDirectoriesInDomains(documentDirectory, userDomainMask, true)
        
        if let dirPath = paths.first {
            let imageUrl = URL(fileURLWithPath: dirPath).appendingPathComponent(fileName)
            let image = UIImage(contentsOfFile: imageUrl.path)
            return image
            
        }
        
        return nil
    }
        
    
}
extension Reports_VC: signatureVCDelegate {
   
    
    func setPick(pick: UIImage, status: String, id: String) {
     
        let image = self.loadImageFromDiskWith(fileName: "PickImg")
        let string64 = image?.base64(format: .png)
        let data = "data:image/png;base64,"
        let finalimage = string64 ?? ""
        let finalstring = data + finalimage
        print(status)
        print(id)
        let imageData = image?.jpegData(compressionQuality: 0.7) ?? Data()
        self.uploadImage(reportid: id, image: imageData)
      
        
    }
    
    func setDrop(drop: UIImage, status: String, id: String) {
    
        let image = loadImageFromDiskWith(fileName: "dropImg")
        let string64 = image?.base64(format: .png)
       
       
        let data = "data:image/png;base64,"
        let finalimage = string64 ?? ""
        let finalstring = data + finalimage
      //  self.dropUPnotes(id: id, status: status)
       // self.updatestatusapiwithimage(id: id, status: status, imagestring: finalstring)
    }
    
   
    
   
    
    func setDone() {
       
    }
    
    func setCancel() {
        
    }
    
 
    }
public enum ImageFormat {
    case png
    case jpeg(CGFloat)
}

extension UIImage {
    
    public func base64(format: ImageFormat) -> String? {
        var imageData: Data?
        switch format {
        case .png: imageData = self.pngData()
        case .jpeg(let compression): imageData = self.jpegData(compressionQuality: compression)
        }
        return imageData?.base64EncodedString()
    }
}
