//
//  Profile_VC.swift
//  HeavenlyHands-2
//
//  Created by Abdul Naffay on 11/01/2024.
//

import UIKit
import Presentr

class Profile_VC: UIViewController {
    @IBOutlet weak var ProfileTbl:UITableView!
    @IBOutlet weak var ProfileImg:UIImageView!
    @IBOutlet weak var EditProfileBtn:UIButton!
    @IBOutlet weak var nameLbl:UILabel!
    @IBOutlet weak var ProfileimageChngView:UIView!
    @IBOutlet weak var CamraBtn:UIButton!
    
    
    var isEditingProfile = false

    
//    var itemsArray = [String]()
    
    var itemsArray : [String] = []
    
    var iconImagesArray = [String]()
    
    var ProfileArray:ProfileModel? {
        didSet{
            ProfileTbl.reloadData()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
//itemsArray = ["jameswilliam@gmail.com","+92 123 456789","Adress","19-12-1985","General Details"]
        iconImagesArray = ["email_icon","telephone_126523 1","location_684809 1","calendar_2589240 1","index_6639076 1"]
        
        self.ProfileApi("\(AppDefault.currentUser?.firstName ?? "")", "\(AppDefault.currentUser?.lastName ?? "")", "\(AppDefault.currentUser?.dateOfBirth ?? "")", "\(AppDefault.currentUser?.gender ?? "")", "\(AppDefault.currentUser?.email ?? "")", "\(AppDefault.currentUser?.cnic ?? "")", "\(AppDefault.currentUser?.ssn ?? "")", "\(AppDefault.currentUser?.mobileNumber ?? "")", "\(AppDefault.currentUser?.homeNumber ?? "")", "Street_adress", "City","state", "zip_Code")
        
        
        
        // Do any additional setup after loading the view.
//        itemsArray.append(DetailsFld.text!)

    
    }
    override func viewWillAppear(_ animated: Bool) {
        ProfileTbl.delegate = self
        ProfileTbl.dataSource = self
        
    }
    private  func ProfileApi(_ first_name:String,_ last_name:String,_ date_of_birth:String,_ gender:String,_ email:String,_ cnic:String,_ ssn:String,_ mobile_number:String,_ home_number:String,_ street_address:String,_ city:String,_ state:String,_ zip_code:String) {
       
        APIServices.ProfileApi(first_name:first_name,last_name: last_name,date_of_birth: date_of_birth,gender: gender,email: email,cnic: cnic,ssn: ssn,mobile_number: mobile_number,home_number: home_number,street_address: street_address,city: city,state: state,zip_code: zip_code) {(result) in
            switch result{
            case .success(let response):
                self.ProfileArray = response
                self.itemsArray.removeAll()
                self.itemsArray.append(response.email ?? "")
                self.itemsArray.append(response.mobileNumber ?? "")
                self.itemsArray.append(response.address?.streetAddress ?? "")
                self.itemsArray.append(response.dateOfBirth ?? "")
                self.itemsArray.append("General Details")
                
                
                self.nameLbl.text = "\(response.name ?? "")"
                self.ProfileImg.pLoadImage(url: appdelegate.imagebaseurl + (AppDefault.currentUser?.file ?? ""))
                self.ProfileTbl.reloadData()

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
            
            
        }
    }
    @IBAction func BackBtn(_ Sender:Any){
//        navigationController?.popViewController(animated: true)
        self.sideMenuController?.toggle()

    }

    // MARK: - IBActions

    @IBAction func editProfileButtonTapped(_ sender: UIButton) {
        if isEditingProfile {
            // Handle Save action
            // Iterate through text fields in cells to retrieve edited data and save it
            
//            var editedDataArray = [String]()
           
            
            // Here, you can handle saving the edited data
            // e.g., you can update your data model with the new values in editedDataArray
            // Once the data is saved, you might want to disable editing mode and update UI accordingly
            isEditingProfile = false
            ProfileimageChngView.isHidden = true
//            CamraBtn.isHidden = true
            EditProfileBtn.setTitle("Edit Profile", for: .normal)
            ProfileTbl.reloadData()
        } else {
            // Handle Edit action
            isEditingProfile = true
//            CamraBtn.isHidden = false
            ProfileimageChngView.isHidden = false
            self.view.makeToast("Now You Can Edit Details")
            EditProfileBtn.setTitle("Save", for: .normal)
            
            ProfileTbl.reloadData()
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

}
extension Profile_VC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ProfileTbl.dequeueReusableCell(withIdentifier: "ProfileVC_Cell", for: indexPath)as! ProfileVC_Cell
        // Check if the indexPath.row is 0 or 4, and disable editing accordingly
           if indexPath.row == 0 || indexPath.row == 4 {
               cell.DetailsFld.isEnabled = false
           } else {
               cell.DetailsFld.isEnabled = isEditingProfile
           }

//        cell.DetailsFld.isEnabled = isEditingProfile
        cell.DetailsFld.text = itemsArray[indexPath.row]
        cell.iconImages.image = UIImage(named: iconImagesArray[indexPath.row])
        return cell
        
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
        
    }
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
          // Disable selection for the first three cells
          if indexPath.row < 4 {
              return nil
          }
          // Enable selection for the fourth cell
        
          return indexPath
      }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dict = itemsArray[indexPath.row]
        if (dict == "General Details"){
            let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            let destination = storyboard.instantiateViewController(withIdentifier: "GeneralDetails_VC") as! GeneralDetails_VC
            destination.ProfileArray = ProfileArray
            navigationController?.pushViewController(destination, animated: true)
            dismiss(animated: true, completion: nil)
            ProfileTbl.deselectRow(at: indexPath, animated: true)
            
        }else{
            
        }
    }
}

