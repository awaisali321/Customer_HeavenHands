//
//  Documents_View_VC.swift
//  HeavenlyHands-2
//
//  Created by Abdul Naffay on 15/02/2024.
//

import UIKit
import WebKit
import JGProgressHUD

class Documents_View_VC: UIViewController, WKUIDelegate {
    @IBOutlet weak var displayImage:UIImageView!
    @IBOutlet weak var WebView_View:WKWebView!
    var PathLbl = String()
    let progressHUD = JGProgressHUD(style: .dark)
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        WebView_View = WKWebView(frame: .zero, configuration: webConfiguration)
        WebView_View.uiDelegate = self
        view = WebView_View
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        progressHUD.interactionType = .blockAllTouches

            // Show HUD
            progressHUD.show(in: self.view)
//              loadHTMLString()
            // Perform some task
            performTask {
                // Dismiss HUD when the task is complete
                self.progressHUD.dismiss()
            }
//        if PathLbl.contains(".pdf") {
//                   // Show PDF in webView
//            WebView_View.isHidden = false
//            displayImage.isHidden = true
//            if let pdfURL = Bundle.main.url(forResource: "\(PathLbl)", withExtension: ".pdf") {
//                       let request = URLRequest(url: pdfURL)
//                WebView_View.load(request)
//
//                   }
//               } else {
//                   // Show image in imageView
//
//                   WebView_View.isHidden = true
//                   displayImage.isHidden = false
//
//                   displayImage.image = UIImage(named: "\(PathLbl)")
//                   }
//
//        if let url = URL(string: PathLbl) {
//                if PathLbl.contains(".pdf") {
//                    // Show PDF in webView
//                    WebView_View.isHidden = false
//                    displayImage.isHidden = true
//
//                    let request = URLRequest(url: url)
//                    WebView_View.load(request)
//                } else {
//                    // Show image in imageView
//                    WebView_View.isHidden = true
//                    displayImage.isHidden = false
//
//                    displayImage.image = UIImage(named: PathLbl)
//                }
//            } else {
//                // Handle invalid URL
//                print("Invalid URL: \(PathLbl)")
//            }
        
//        // Define your base URL
//           let baseURLString = "https://dev-api-ch.10bytestech.com/"
//
//           if let baseURL = URL(string: baseURLString), let relativeURL = URL(string: PathLbl, relativeTo: baseURL) {
//               if PathLbl.contains(".pdf") {
//                   // Show PDF in webView
//                   WebView_View.isHidden = false
//                   displayImage.isHidden = true
//
//                   let request = URLRequest(url: relativeURL)
//                   WebView_View.load(request)
//               } else {
//                   // Show image in imageView
//                   WebView_View.isHidden = true
//                   displayImage.isHidden = false
//
//                   displayImage.image = UIImage(named: PathLbl)
//               }
//           } else {
//               // Handle invalid base URL or relative URL
//               print("Invalid base URL or relative URL: \(baseURLString), \(PathLbl)")
//           }
               
        // Do any additional setup after loading the view.
    }
    func performTask(completion: @escaping () -> Void) {
        // Simulate a task
//        func loadHTMLString() {
  //          let htmlString = "\(appdelegate.imagebaseurl + (PathLbl))"
//            let htmlString =  PathLbl
//            WebView_View.loadHTMLString(htmlString, baseURL: URL(string: "https://dev-api-ch.10bytestech.com/"))
        
        // Define your base URL
           let baseURLString = "https://dev-api-ch.10bytestech.com/"
           
           if let baseURL = URL(string: baseURLString), let relativeURL = URL(string: PathLbl, relativeTo: baseURL) {
               if PathLbl.contains(".pdf") {
                   // Show PDF in webView
                   WebView_View.isHidden = false
                   displayImage.isHidden = true
                   
                   let request = URLRequest(url: relativeURL)
                   WebView_View.load(request)
               } else {
                   // Show image in imageView
                   WebView_View.isHidden = true
                   displayImage.isHidden = false
                   
                   displayImage.image = UIImage(named: PathLbl)
               }
           } else {
               // Handle invalid base URL or relative URL
               print("Invalid base URL or relative URL: \(baseURLString), \(PathLbl)")
           }
            
//        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            // Task complete, call the completion block
            completion()
        }
    }
    @IBAction func BackBtn(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        
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
