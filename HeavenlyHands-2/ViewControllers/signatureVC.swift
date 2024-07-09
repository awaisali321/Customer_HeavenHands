//
//  CustomAlertViewController.swift
//  EzPopup_Example
//
//  Created by Huy Nguyen on 6/4/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit
import MediaPlayer
import AVFoundation
import AudioToolbox
import SwiftSignatureView

protocol signatureVCDelegate: class {
    func setPick (pick: UIImage,status:String,id:String)
    func setDrop (drop: UIImage,status:String,id:String)
}
class signatureVC: UIViewController,YPSignatureDelegate {
    
    weak var delegate: signatureVCDelegate?
    @IBOutlet weak var signatureView: YPDrawSignatureView!
    
    var type = ""
    var statustrip = ""
    var Tripid = String()
    
    
    static func instantiate() -> signatureVC? {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "\(signatureVC.self)") as? signatureVC
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        signatureView.delegate = self
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        
    }
    @IBAction func CaptureSignatureButton(_ sender: Any) {
        if self.signatureView.getSignature(scale: 10) != nil {
            let imageName = signatureView.getSignature()
            let imageView = UIImageView()
            imageView.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
            imageView.image = imageName
            if(type == "P"){
             saveImage(imageName: "PickImg", image: imageName!)
             self.signatureView.clear()
                delegate?.setPick(pick: imageName!,status:statustrip,id:Tripid)
            }else {
             saveImage(imageName: "dropImg", image: imageName!)
             self.signatureView.clear()
              //  delegate?.setDrop(drop: imageName!,status:statustrip,id:Tripid)
            }
            dismiss(animated: true, completion: nil)
        }
        
    }
    @IBAction func clear(_ sender: Any) {
        signatureView.clear()
    }
    
    func didStart(_ view : YPDrawSignatureView) {
        print("Started Drawing")
    }
    
    // didFinish() is called rigth after the last touch of a gesture is registered in the view.
    // Can be used to enabe scrolling in a scroll view if it has previous been disabled.
    func didFinish(_ view : YPDrawSignatureView) {
        print("Finished Drawing")
    }
    
    func saveImage(imageName: String, image: UIImage) {


     guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }

        let fileName = imageName
        let fileURL = documentsDirectory.appendingPathComponent(fileName)
        guard let data = image.jpegData(compressionQuality: 1) else { return }

        //Checks if file exists, removes it if so.
        if FileManager.default.fileExists(atPath: fileURL.path) {
            do {
                try FileManager.default.removeItem(atPath: fileURL.path)
                print("Removed old image")
            } catch let removeError {
                print("couldn't remove file at path", removeError)
            }

        }

        do {
            try data.write(to: fileURL)
        } catch let error {
            print("error saving file with error", error)
        }

    }
}


