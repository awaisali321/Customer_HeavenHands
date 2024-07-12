//
//  Profile_VC.swift
//  HeavenlyHands-2
//
//  Created by Abdul Naffay on 11/01/2024.
//

import UIKit
import Presentr

class Profile_VC: UIViewController {
    @IBOutlet weak var ProfileImg:UIImageView!
    @IBOutlet weak var EditProfileBtn:UIButton!
    @IBOutlet weak var nameLbl:UILabel!
    @IBOutlet weak var ProfileimageChngView:UIView!
    @IBOutlet weak var CamraBtn:UIButton!
    
    
    @IBOutlet weak var emaillbl: UITextField!
    @IBOutlet weak var phonelbl: UITextField!
    @IBOutlet weak var addresslbl: UITextView!
    @IBOutlet weak var citylbl: UITextField!
    @IBOutlet weak var statelbl: UITextField!
    @IBOutlet weak var dateofbirth: UITextField!
    @IBOutlet weak var generalbl: UITextField!
    var isEditingProfile = false
    var isimage = false
    
//    var itemsArray = [String]()
    
    var itemsArray : [String] = []
    
    var iconImagesArray = [String]()
    
    var ProfileArray:ProfileModel? {
        didSet{
           
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
//itemsArray = ["jameswilliam@gmail.com","+92 123 456789","Adress","19-12-1985","General Details"]
        iconImagesArray = ["email_icon","telephone_126523 1","location_684809 1","calendar_2589240 1","index_6639076 1"]
        self.ProfileImg.pLoadImage(url: appdelegate.imagebaseurl + (AppDefault.currentUser?.file ?? ""))
        self.nameLbl.text = (AppDefault.currentUser?.firstName ?? "") + " " + (AppDefault.currentUser?.lastName ?? "")
//        self.ProfileApi("\(AppDefault.currentUser?.firstName ?? "")", "\(AppDefault.currentUser?.lastName ?? "")", "\(AppDefault.currentUser?.dateOfBirth ?? "")", "\(AppDefault.currentUser?.gender ?? "")", "\(AppDefault.currentUser?.email ?? "")", "\(AppDefault.currentUser?.cnic ?? "")", "\(AppDefault.currentUser?.ssn ?? "")", "\(AppDefault.currentUser?.mobileNumber ?? "")", "\(AppDefault.currentUser?.homeNumber ?? "")", "\(AppDefault.currentUser?.address?.formatted ?? "")", "\(AppDefault.currentUser?.address?.city ?? "")","\(AppDefault.currentUser?.address?.state ?? "")", "\(AppDefault.currentUser?.address?.zipCode ?? "")")
//        
//
        self.emaillbl.isUserInteractionEnabled = false
        self.phonelbl.isUserInteractionEnabled = false
        self.addresslbl.isUserInteractionEnabled = false
        self.citylbl.isUserInteractionEnabled = false
        self.statelbl.isUserInteractionEnabled = false
        self.dateofbirth.isUserInteractionEnabled = false
        
        self.emaillbl.text = AppDefault.currentUser?.email
        self.phonelbl.text = AppDefault.currentUser?.mobileNumber
        self.addresslbl.text = AppDefault.currentUser?.address?.formatted
        self.citylbl.text = AppDefault.currentUser?.address?.city
        self.statelbl.text = AppDefault.currentUser?.address?.state
        self.dateofbirth.text = AppDefault.currentUser?.dateOfBirth
        self.generalbl.text = "General Details"
    
    }
    override func viewWillAppear(_ animated: Bool) {
     
    }
    private  func ProfileApi(_ first_name:String,_ last_name:String,_ date_of_birth:String,_ gender:String,_ email:String,_ cnic:String,_ ssn:String,_ mobile_number:String,_ home_number:String,_ street_address:String,_ city:String,_ state:String,_ zip_code:String,_ img:Data) {
       
        APIServices.ProfileApi(first_name:first_name,last_name: last_name,date_of_birth: date_of_birth,gender: gender,email: email,cnic: cnic,ssn: ssn,mobile_number: mobile_number,home_number: home_number,street_address: street_address,city: city,state: state, img: img,zip_code: zip_code) {(result) in
            switch result{
            case .success(let response):
                self.ProfileArray = response
              AppDefault.currentUser?.email =  self.emaillbl.text
               AppDefault.currentUser?.mobileNumber = self.phonelbl.text
               AppDefault.currentUser?.address?.formatted  =  self.addresslbl.text
                AppDefault.currentUser?.address?.city = self.citylbl.text
                 AppDefault.currentUser?.address?.state  = self.statelbl.text
                AppDefault.currentUser?.dateOfBirth  = self.dateofbirth.text
                AppDefault.currentUser?.file  = response.file
                self.ProfileImg.pLoadImage(url: appdelegate.imagebaseurl + (AppDefault.currentUser?.file ?? ""))
              

            case .failure(let error):
                if(error == "Response status code was unacceptable: 500."){
                   
                    appdelegate.gotoSignInVc()
                    self.view.makeToast("LogIn Session Expired")
                }
       
                
            }
        }
    }

    @IBAction func NotificationBtn(_ Sender:Any){
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let destination = storyboard.instantiateViewController(withIdentifier: "Notifications_VC") as! Notifications_VC
        navigationController?.pushViewController(destination, animated: true)
        dismiss(animated: true, completion: nil)

    }
    @IBAction func CameraBtn(_ sender: Any) {
        ImagePickerManager().pickImage(self){ image in
            self.ProfileImg.image = image.pResizeWith(width: 80)
            
           
            self.isimage = true
        }
    }
    
  
    
    
    @IBAction func BackBtn(_ Sender:Any){
//        navigationController?.popViewController(animated: true)
        self.sideMenuController?.toggle()

    }

    @IBAction func generalbtn(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let destination = storyboard.instantiateViewController(withIdentifier: "GeneralDetails_VC") as! GeneralDetails_VC
        destination.ProfileArray = ProfileArray
        navigationController?.pushViewController(destination, animated: true)
      
  

        
    }
    // MARK: - IBActions

    @IBAction func editProfileButtonTapped(_ sender: UIButton) {
        if isEditingProfile{
 
            let imageData = self.ProfileImg.image?.jpegData(compressionQuality: 0.7) ?? Data()
            self.ProfileApi("\(AppDefault.currentUser?.firstName ?? "")", "\(AppDefault.currentUser?.lastName ?? "")", "\(self.dateofbirth?.text ?? "")", "\(AppDefault.currentUser?.gender ?? "")", "\(AppDefault.currentUser?.email ?? "")", "\(AppDefault.currentUser?.cnic ?? "")", "\(AppDefault.currentUser?.ssn ?? "")", "\(self.phonelbl?.text ?? "")", "\(AppDefault.currentUser?.homeNumber ?? "")", "\(self.addresslbl?.text ?? "")","\(self.citylbl?.text ?? "")","\(self.statelbl?.text ?? "")", "\(AppDefault.currentUser?.address?.zipCode ?? "")", imageData)
            
            
            ProfileimageChngView.isHidden = true

            EditProfileBtn.setTitle("Edit Profile", for: .normal)
            self.emaillbl.isUserInteractionEnabled = false
            self.phonelbl.isUserInteractionEnabled = false
            self.addresslbl.isUserInteractionEnabled = false
            self.citylbl.isUserInteractionEnabled = false
            self.statelbl.isUserInteractionEnabled = false
            self.dateofbirth.isUserInteractionEnabled = false
            isEditingProfile = false
        } else {
            // Handle Edit action
            isEditingProfile = true
//            CamraBtn.isHidden = false
            ProfileimageChngView.isHidden = false
            self.emaillbl.isUserInteractionEnabled = false
            self.phonelbl.isUserInteractionEnabled = true
            self.addresslbl.isUserInteractionEnabled = true
            self.citylbl.isUserInteractionEnabled = true
            self.statelbl.isUserInteractionEnabled = true
            self.dateofbirth.isUserInteractionEnabled = true
        
            EditProfileBtn.setTitle("Save", for: .normal)
            
            
            
            
            
            
           
        }
    }
 
}


