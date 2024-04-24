//
//  Appointments_VC.swift
//  HeavenlyHands-2
//
//  Created by Abdul Naffay on 11/01/2024.
//

import UIKit

class Appointments_VC: UIViewController {
    @IBOutlet weak var AppointmentsTbl:UITableView!
    var ApoinmentsNamesArray = [String]()
    var TimeArray = [String]()
    var DatesArray = [String]()
    var AppointmentsmodelArray:AppointmentsModel? {
        didSet{
            AppointmentsTbl.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        ApoinmentsNamesArray = ["Appointments 01","Appointments 02","Appointments 03"]
        TimeArray = ["10:15 pm","10:20 pm","10:30 pm"]
        DatesArray = ["08-01-2024","09-01-2024","10-01-2024"]
        
        if let dateString = AppointmentsmodelArray?.data?.first?.nameDate {
            // Convert the string representation of dates to an array of Date objects
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd-MM-yyyy" // Adjust date format as per your string
            
            let datesArray = dateString.components(separatedBy: ", ")
                                        .compactMap { dateFormatter.date(from: $0) }
            
            // Sort the array of Date objects
            let sortedDates = datesArray.sorted()
            
            // Now you have sorted dates, you can use them as needed
        }
        
        self.AppointmentsApi()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        AppointmentsTbl.delegate = self
        AppointmentsTbl.dataSource = self
    }
    @IBAction func btn_open_menu(_ Sender:Any){
        self.sideMenuController?.toggle()

    }
    @IBAction func NotificationBtn(_ Sender:Any){
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let destination = storyboard.instantiateViewController(withIdentifier: "Notifications_VC") as! Notifications_VC
        navigationController?.pushViewController(destination, animated: true)
        dismiss(animated: true, completion: nil)

    }
    
    private  func AppointmentsApi() {
        APIServices.AppointmentsApi() {(result) in
            switch result{
            case .success(let response):
                self.AppointmentsmodelArray = response
               
                if(response.data?.isEmpty == true){
                    self.view.makeToast("No Data Found")
                }else{
                    
                }

            case .failure(let error):
                if(error == "Response status code was unacceptable: 500."){
                    
                    appdelegate.gotoSignInVc()
                    self.view.makeToast("LogIn Session Expired")
                }
       
                
            }
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
extension Appointments_VC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AppointmentsmodelArray?.data?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        

        let cell = AppointmentsTbl.dequeueReusableCell(withIdentifier: "AppointmentsVC_Cell", for: indexPath)as! AppointmentsVC_Cell
        let data = AppointmentsmodelArray?.data?[indexPath.row]
        cell.appointmentNameLbl.text = data?.title
        cell.TimeLbl.text = data?.startDate?.pToDate()?.currentTimeStamp
        cell.datesLbl.text = data?.startDate?.pToDate()?.getFormattedDate(format: "dd-MM-yyyy")
        

        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
         return 60
    }
    
}
