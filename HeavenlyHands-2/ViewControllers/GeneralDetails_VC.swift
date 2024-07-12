//
//  GeneralDetails_VC.swift
//  HeavenlyHands-2
//
//  Created by Abdul Naffay on 11/01/2024.
//

import UIKit

class GeneralDetails_VC: UIViewController {
    @IBOutlet weak var ProfileImg:UIImageView!
    @IBOutlet weak var GeneralDetailsTbl:UITableView!
    @IBOutlet weak var ProfileimageChngView:UIView!
    @IBOutlet weak var EditProfileBtn:UIButton!
    @IBOutlet weak var nameLbl:UILabel!
    var isEditingProfile = false
    var detailArray = [String]()
   
    var detailDataArray : [String] = []
    var ProfileArray:ProfileModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.detailDataArray.append(AppDefault.currentUser?.cnic ?? "")
        self.detailDataArray.append(AppDefault.currentUser?.gender ?? "")
//        self.detailDataArray.append(AppDefault.currentUser?.homeNumber ?? "")
//        self.detailDataArray.append(AppDefault.currentUser?.ssn ?? "")
        self.detailArray = ["CIN","Gender"]
     
        self.nameLbl.text = (AppDefault.currentUser?.firstName ?? "") + " " + (AppDefault.currentUser?.lastName ?? "")
        self.ProfileImg.pLoadImage(url: appdelegate.imagebaseurl + (AppDefault.currentUser?.file ?? ""))
        self.GeneralDetailsTbl.reloadData()
        
//        detailDataArray = ["4156356325632563","Male","10’6”","65.52"]
        // Do any additional setup after loading the view.
      
    
        
    }
    override func viewWillAppear(_ animated: Bool) {
        GeneralDetailsTbl.dataSource = self
        GeneralDetailsTbl.delegate = self
    }

    @IBAction func NotificationBtn(_ Sender:Any){
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let destination = storyboard.instantiateViewController(withIdentifier: "Notifications_VC") as! Notifications_VC
        navigationController?.pushViewController(destination, animated: true)
        dismiss(animated: true, completion: nil)

    }
 
    @IBAction func editProfileButtonTapped(_ sender: UIButton) {
        if isEditingProfile {
            // Handle Save action
            // Iterate through text fields in cells to retrieve edited data and save it
            
//            var editedDataArray = [String]()
            for cell in GeneralDetailsTbl.visibleCells as! [GeneralDetailsVC_Cell] {
                detailDataArray.append(cell.DetailsFld.text ?? "")
                
                
            }
            
            // Here, you can handle saving the edited data
            // e.g., you can update your data model with the new values in editedDataArray
            // Once the data is saved, you might want to disable editing mode and update UI accordingly
            isEditingProfile = false
            ProfileimageChngView.isHidden = true
//            CamraBtn.isHidden = true
            
            EditProfileBtn.setTitle("Edit Profile", for: .normal)
            GeneralDetailsTbl.reloadData()
        } else {
            // Handle Edit action
            isEditingProfile = true
//            CamraBtn.isHidden = false
            ProfileimageChngView.isHidden = false
            self.view.makeToast("Now You Can Edit Details")
            EditProfileBtn.setTitle("Save", for: .normal)
            GeneralDetailsTbl.reloadData()
            
        }
    }
    @IBAction func CameraBtn(_ sender: Any) {
        ImagePickerManager().pickImage(self){ image in
            self.ProfileImg.image = image.pResizeWith(width: 80)

        }
        
    }
    @IBAction func BackBtn(_ Sender:Any){
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
extension GeneralDetails_VC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return detailDataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = GeneralDetailsTbl.dequeueReusableCell(withIdentifier: "GeneralDetailsVC_Cell", for: indexPath)as! GeneralDetailsVC_Cell
        cell.DetailLbl.text = detailArray[indexPath.row]
        cell.DetailsFld.text = detailDataArray[indexPath.row]
        cell.DetailsFld.isEnabled = isEditingProfile
        return cell
        
    }
//    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
//          // Disable selection for the cells
//              return nil
//      }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
        
    }
    
}
