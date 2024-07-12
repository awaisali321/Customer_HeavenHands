//
//  ReportsView_VC.swift
//  HeavenlyHands-2
//
//  Created by Abdul Naffay on 24/01/2024.
//

import UIKit
import WebKit
import JGProgressHUD
import EzPopup
class ReportsView_VC: UIViewController{
    @IBOutlet weak var WebView_View:WKWebView!
    @IBOutlet weak var headerlbl:UILabel!
    @IBOutlet weak var signaturebtn:UIButton!
    var ReportsmodelArray:ReportsModel?
    var datamdl: ReportsDatum?
    var PathLbl = String()
    var iscome = String()
    let progressHUD = JGProgressHUD(style: .dark)

        
    override func viewDidLoad() {
        
        
        
        if(datamdl?.patient_signature != nil || datamdl?.type == "INDIVIDUAL SERVICE REPORT (ISR)"){
        
            self.signaturebtn.isHidden = true
        }else{
            
            self.signaturebtn.isHidden = false
        }
        if(iscome == "report"){
            headerlbl.text = "View Reports"
        }else{
            headerlbl.text = "View Documents"
        }
        super.viewDidLoad()
        progressHUD.interactionType = .blockNoTouches

            // Show HUD
            progressHUD.show(in: self.view)
//              loadHTMLString()
            // Perform some task
            performTask {
                // Dismiss HUD when the task is complete
                self.progressHUD.dismiss()
            }
        
//          WebView_View.navigationDelegate = self
         

         
      }

    @IBAction func addsignature(_ sender: Any) {
        let data = datamdl
        let pickerVC_self = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "signatureVC") as? signatureVC
        pickerVC_self?.Tripid = "\(data?.id ?? 0)"
        pickerVC_self?.type = "P"
        pickerVC_self?.delegate = self
        let popupVC = PopupViewController(contentController: pickerVC_self!, popupWidth: 310,popupHeight: 480)
        popupVC.cornerRadius = 10
        present(popupVC, animated: true, completion: nil)
    }
    @IBAction func NotificationBtn(_ Sender:Any){
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let destination = storyboard.instantiateViewController(withIdentifier: "Notifications_VC") as! Notifications_VC
        navigationController?.pushViewController(destination, animated: true)
        dismiss(animated: true, completion: nil)

    }
    func performTask(completion: @escaping () -> Void) {
        // Simulate a task
//        func loadHTMLString() {
  //          let htmlString = "\(appdelegate.imagebaseurl + (PathLbl))"
            let htmlString =  PathLbl
            WebView_View.loadHTMLString(htmlString, baseURL: URL(string: "https://dev-api-ch.10bytestech.com/"))
            
//        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            // Task complete, call the completion block
            completion()
        }
    }
    
    @IBAction func BackBtn(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

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
    private func uploadImage(reportid: String, image: Data) {
           APIServices.uploadImage(reportid: reportid, image: image) { (result) in
               switch result {
               case .success(let response):
                  
                   // Handle success response
                  self.view.makeToast("Image uploaded successfully")
                   self.navigationController?.popViewController(animated: true)
                   
               case .failure(let error):
                   print("Image upload failed with error: \(error)")
                   if error == "Response status code was unacceptable: 500." {
                       appdelegate.gotoSignInVc()
                       self.view.makeToast("LogIn Session Expired")
                   } else {
                       
                       // Handle success response
                      self.view.makeToast("Image uploaded successfully")
                       self.navigationController?.popViewController(animated: true)
                   }
               }
           }
       }
    
}
extension ReportsView_VC: signatureVCDelegate {
   
    
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
