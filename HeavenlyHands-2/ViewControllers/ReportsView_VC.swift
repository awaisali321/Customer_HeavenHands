//
//  ReportsView_VC.swift
//  HeavenlyHands-2
//
//  Created by Abdul Naffay on 24/01/2024.
//

import UIKit
import WebKit
import JGProgressHUD

class ReportsView_VC: UIViewController{
    @IBOutlet weak var WebView_View:WKWebView!
    @IBOutlet weak var headerlbl:UILabel!
    var ReportsmodelArray:ReportsModel?
    var PathLbl = String()
    var iscome = String()
    let progressHUD = JGProgressHUD(style: .dark)

        
    override func viewDidLoad() {
        
        
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

}
