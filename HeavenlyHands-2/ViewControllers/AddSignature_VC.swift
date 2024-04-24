//
//  AddSignature_VC.swift
//  HeavenlyHands-2
//
//  Created by Abdul Naffay on 13/01/2024.
//

import UIKit
import WebKit


class AddSignature_VC: UIViewController {
    @IBOutlet weak var WebView_View:WKWebView!
    @IBOutlet weak var signatureView: SignatureView!
    
    
    var taskmodelArray:TasksModel?
    var PathLbl = String()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let request = URLRequest(url: URL(string: "\(PathLbl)")!)
        WebView_View?.load(request)
        
        signatureView.layer.cornerRadius = 40
        signatureView.layer.shadowOpacity = 2
        signatureView.layer.masksToBounds = true
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func BackBtn(_ Sender:Any){
        navigationController?.popViewController(animated: true)
       
    }
    @IBAction func SubmitSignBtn(_ Sender:Any){
        
       
    }
    @IBAction func clearSignature(_ sender: UIButton) {
           signatureView.clear()
       }
    func getSignatureImage() -> UIImage? {
         UIGraphicsBeginImageContextWithOptions(signatureView.bounds.size, false, 0)
         defer { UIGraphicsEndImageContext() }
         guard let context = UIGraphicsGetCurrentContext() else { return nil }
         signatureView.layer.render(in: context)
         return UIGraphicsGetImageFromCurrentImageContext()
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
//extension AddSignature_VC:UIWebViewDelegate{
//
//    private func webViewDidStartLoad(_ WebView_View: WKWebView){
//        activity.startAnimating()
//            NSLog("Webview load has started")
//    } // show indicator
//    private func webViewDidFinishLoad(_ WebView_View: WKWebView){
//        activity.startAnimating()
//            NSLog("Webview load has started")
//    }
//}

class SignatureView: UIView {

    private var path = UIBezierPath()
    private var strokeColor = UIColor.black
    private var strokeWidth: CGFloat = 2.0
    private let instructionLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLabel()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupLabel()
    }

    private func setupLabel() {
        instructionLabel.text = "Add your signature here"
        instructionLabel.textColor = UIColor.gray
        instructionLabel.font = UIFont.systemFont(ofSize: 16)
        instructionLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(instructionLabel)

        NSLayoutConstraint.activate([
            instructionLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            instructionLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }

    override func draw(_ rect: CGRect) {
        strokeColor.setStroke()
        path.stroke()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        
        path.move(to: touch.location(in: self))
        instructionLabel.isHidden = true // Hide the label when touches begin
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        path.addLine(to: touch.location(in: self))
        setNeedsDisplay()
    }

    func clear() {
        path.removeAllPoints()
        setNeedsDisplay()
        instructionLabel.isHidden = false // Show the label when clearing
    }
}

//class SignatureView: UIView {
//
//    private var path = UIBezierPath()
//    private var strokeColor = UIColor.black
//    private var strokeWidth: CGFloat = 2.0
//    private let instructionLabel = UILabel()
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setupLabel()
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//        setupLabel()
//    }
//
//    private func setupLabel() {
//        instructionLabel.text = "Add your signature here"
//        instructionLabel.textColor = UIColor.gray
//        instructionLabel.font = UIFont.systemFont(ofSize: 16)
//        instructionLabel.translatesAutoresizingMaskIntoConstraints = false
//        addSubview(instructionLabel)
//
//        NSLayoutConstraint.activate([
//            instructionLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
//            instructionLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
//        ])
//    }
//
//    override func draw(_ rect: CGRect) {
//        strokeColor.setStroke()
//        path.stroke()
//    }
//
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        guard let touch = touches.first else { return }
//
//        path.move(to: touch.location(in: self))
//    }
//
//    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
//        guard let touch = touches.first else { return }
//        path.addLine(to: touch.location(in: self))
//        setNeedsDisplay()
//    }
//
//    func clear() {
//        path.removeAllPoints()
//        setNeedsDisplay()
//    }
//}

//class SignatureView: UIView {
//
//    private var path = UIBezierPath()
//    private var strokeColor = UIColor.black
//    private var strokeWidth: CGFloat = 2.0
//
//    override func draw(_ rect: CGRect) {
//        strokeColor.setStroke()
//        path.stroke()
//    }
//
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        guard let touch = touches.first else { return }
//
//        path.move(to: touch.location(in: self))
//    }
//
//    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
//        guard let touch = touches.first else { return }
//        path.addLine(to: touch.location(in: self))
//        setNeedsDisplay()
//    }
//
//    func clear() {
//        path.removeAllPoints()
//        setNeedsDisplay()
//    }
//}
