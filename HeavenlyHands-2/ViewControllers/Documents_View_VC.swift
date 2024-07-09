
import UIKit
import WebKit

class Documents_View_VC: UIViewController, WKNavigationDelegate {

    @IBOutlet weak var WebView_View: UIView! // Change type to UIView
    private var webView: WKWebView! // Strong reference to the web view
    var PathLbl = String()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Initialize the web view and set the navigation delegate
        webView = WKWebView(frame: .zero)
        webView.navigationDelegate = self
        
        // Add the web view to the view hierarchy
        WebView_View.addSubview(webView)
        
        // Set up auto layout constraints
        webView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            webView.leadingAnchor.constraint(equalTo: WebView_View.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: WebView_View.trailingAnchor),
            webView.topAnchor.constraint(equalTo: WebView_View.topAnchor),
            webView.bottomAnchor.constraint(equalTo: WebView_View.bottomAnchor)
        ])
        
        // Load a URL
        if let url = URL(string: PathLbl) {
            let request = URLRequest(url: url)
            webView.load(request)
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
    
    // WKNavigationDelegate methods
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("Started to load")
        // Show loading indicator if needed
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("Finished loading")
        // Hide loading indicator if needed
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        print("Failed to load with error: \(error.localizedDescription)")
        // Handle error
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        print("Failed provisional navigation: \(error.localizedDescription)")
        // Handle error
    }
}
