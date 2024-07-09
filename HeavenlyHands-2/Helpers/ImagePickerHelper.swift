//
//  ImagePickerHelper.swift
//  E learners
//
//  Created by Abdul Naffay on 16/11/2023.
//

import Foundation
import Presentr
import UniformTypeIdentifiers
import PDFKit
import QuickLook

class ImagePickerManager: NSObject, UIImagePickerControllerDelegate,UIDocumentPickerDelegate, UINavigationControllerDelegate {

    var picker = UIImagePickerController();
    var alert = UIAlertController(title: "Select", message: nil, preferredStyle: .actionSheet)
    var viewController: UIViewController?
    var pickImageCallback : ((UIImage) -> ())?;
//    var pickDocumentCallback: ((PDFDocument) -> ())?;
    
    override init(){
        super.init()

        let cameraAction = UIAlertAction(title: "Camera", style: .default){
            UIAlertAction in
            self.openCamera()
        }
        let galleryAction = UIAlertAction(title: "Gallery", style: .default){
            UIAlertAction in
            self.openGallery()
        }
//        let SelectFromFilesAction = UIAlertAction(title: "Files", style: .default){
//            UIAlertAction in
//            self.SelectFormFiles()
//        }

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel){
            UIAlertAction in
        }

        // Add the actions
        picker.delegate = self
        alert.addAction(cameraAction)
        alert.addAction(galleryAction)
        alert.addAction(cancelAction)
//        alert.addAction(SelectFromFilesAction)
    }

    func pickImage(_ viewController: UIViewController, _ callback: @escaping ((UIImage) -> ())) {
        pickImageCallback = callback;
        self.viewController = viewController;

        alert.popoverPresentationController?.sourceView = self.viewController!.view

        viewController.present(alert, animated: true, completion: nil)
    }
//    func pickDocument(_ viewController: UIViewController, _ callback2: @escaping ((PDFDocument) -> ())) {
//        pickDocumentCallback = callback2;
//        self.viewController = viewController;
//
//        alert.popoverPresentationController?.sourceView = self.viewController!.view
//
//        viewController.present(alert, animated: true, completion: nil)
//    }
    func openCamera(){
        alert.dismiss(animated: true, completion: nil)
        if(UIImagePickerController .isSourceTypeAvailable(.camera)){
            picker.sourceType = .camera
            self.viewController!.present(picker, animated: true, completion: nil)
        } else {
            let alertController: UIAlertController = {
                let controller = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .default)
                controller.addAction(action)
                return controller
            }()
            viewController?.present(alertController, animated: true)
        }
    }
    func openGallery(){
        alert.dismiss(animated: true, completion: nil)
        picker.sourceType = .photoLibrary
        self.viewController!.present(picker, animated: true, completion: nil)
    }
    func SelectFormFiles(){
        
        if #available(iOS 14.0, *) {
            let supportedTypes: [UTType] = [UTType.pdf,UTType.image,UTType.jpeg,UTType.png]
            let pickerViewController = UIDocumentPickerViewController(forOpeningContentTypes: supportedTypes, asCopy: true)
            pickerViewController.delegate = self
            pickerViewController.allowsMultipleSelection = false
            pickerViewController.shouldShowFileExtensions = true
            self.viewController!.present(pickerViewController, animated: true, completion: nil)
//            self.present(pickerViewController, animated: true, completion: nil)

        } else {
            // Fallback on earlier versions
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }

    //for swift below 4.2
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
//        picker.dismiss(animated: true, completion: nil)
//        let image = info[UIImagePickerController.InfoKey.originalImage.rawValue] as! UIImage
//        pickImageCallback?(image)
//    }
    
    // For Swift 4.2+
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        guard let image = info[.originalImage] as? UIImage else {
            
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        pickImageCallback?(image)
    }
    
//    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
//        if let selectedURL = urls.first {
//
////            displayDocument(at: selectedURL)
//            saveUploadedFile(selectedURL)
//
//
//        }
//    }
//    private func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [PDFDocument]) {
//        guard let selectedURL = urls.first else {
//            // Handle the case where no documents are selected
//            return
//        }
//        displayPDFPage(url: selectedURL, pageIndex: 0)
//        pickDocumentCallback?(selectedURL)
//        // Other actions you want to perform with the selected document
//    }
    private func displayPDFPage(url: URL, pageIndex: Int) {
        if let pdfDocument = PDFDocument(url: url),
            let pdfPage = pdfDocument.page(at: pageIndex) {
            // Convert PDF page to an image
            let renderer = UIGraphicsImageRenderer(size: pdfPage.bounds(for: .mediaBox).size)

            let pdfImage = renderer.image { (context) in
                UIColor.white.set()
                context.fill(pdfPage.bounds(for: .mediaBox))

                context.cgContext.translateBy(x: 0.0, y: pdfPage.bounds(for: .mediaBox).size.height)
                context.cgContext.scaleBy(x: 1.0, y: -1.0)

                pdfPage.draw(with: .mediaBox, to: context.cgContext)
            }

            // Display the PDF image in the UIImageView
            UIImageView().image = pdfImage
        }
    }

    @objc func imagePickerController(_ picker: UIImagePickerController, pickedImage: UIImage?) {
        
    }

}
