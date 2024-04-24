//
//  ReportsVC.swift
//  HeavenlyHands-2
//
//  Created by Abdul Naffay on 10/01/2024.
//

import UIKit

class Reports_VC: UIViewController {
    @IBOutlet weak var ReportsTbl:UITableView!
    var DocumentsNamesArray = [String]()
    var DatesArray = [String]()
    var TimeArray = [String]()
    var ReportsmodelArray:ReportsModel? {
        didSet{
            ReportsTbl.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DocumentsNamesArray = ["Report 01","Report 02","Report 03","Report 04","Report 05","Report 06","Report 07"]
        DatesArray = ["07-01-2024","08-01-2024","09-01-2024","10-01-2024","11-01-2024","12-01-2024","13-01-2024"]
        TimeArray = ["11:00 am","12:00 pm","01:00 pm","03:00 pm","04:00 pm","05:00 pm","06:00 pm"]
       
        self.ReportsApi()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        ReportsTbl.dataSource = self
        ReportsTbl.delegate = self
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
    @objc func PdfDownloadBtn(sender: UIButton){
        let data = ReportsmodelArray?.data?[sender.tag]
        if(data?.file?.isEmpty == false){
            let fileURLs : String = "\(appdelegate.imagebaseurl)" + "\(data?.file ?? "")";
            
            
            DispatchQueue.main.async {
                if let url = URL(string: fileURLs) {
                    do {
                        let pdfData = try Data(contentsOf: url)

                        let resDocPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last!

                        // Use the actual file extension from the URL
                        let pdfFileName = UUID().uuidString + (url.pathExtension.isEmpty ? "" : ".\(url.pathExtension).pdf")

                        let filePath = resDocPath.appendingPathComponent(pdfFileName)

                        // Save to Files
                        try pdfData.write(to: filePath, options: .atomic)
                        print("File Saved")
                        self.view.makeToast("File Download Successfully")
                    } catch {
                        print("Error downloading or saving file: \(error.localizedDescription)")
                        self.view.makeToast("Corrupt File")
                    }
                }
            }
            
        }else{
            self.view.makeToast("No Pdf File Found")
        }
    }
    @objc func ReportsViewBtn(sender: UIButton){
        let data = ReportsmodelArray?.data?[sender.tag]
        if (data?.html?.isEmpty == false){
            let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            let destination = storyboard.instantiateViewController(withIdentifier: "ReportsView_VC") as! ReportsView_VC

            destination.PathLbl = data?.html ?? ""

            navigationController?.pushViewController(destination, animated: true)
            dismiss(animated: true, completion: nil)
            
        }else{
            self.view.makeToast("Reports Are Not Ready Yet")
            
        }
    }
    private  func ReportsApi() {
        APIServices.ReportsApi() {(result) in
            switch result{
            case .success(let response):
                self.ReportsmodelArray = response
  
                
                
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
extension Reports_VC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return ReportsmodelArray?.data?.count ?? 0
        
    }
        
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ReportsTbl.dequeueReusableCell(withIdentifier: "Reports_Cell", for: indexPath)as!
        Reports_Cell
        let data = ReportsmodelArray?.data?[indexPath.row]
        cell.ReportNameLbl.text = data?.type
        cell.PdfDownloadBtn.tag = indexPath.row
        cell.PdfDownloadBtn.addTarget(self, action: #selector(PdfDownloadBtn(sender:)), for: .touchUpInside)
        cell.ViewFileBtn.tag = indexPath.row
        cell.ViewFileBtn.addTarget(self, action: #selector(ReportsViewBtn(sender:)), for: .touchUpInside)
        cell.DateLbl.text = data?.createdAt?.pToDate()?.getFormattedDate(format: "dd-MM-yyyy")
        cell.TimeLbl.text = data?.createdAt?.pToDate()?.currentTimeStamp
    
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let data = ReportsmodelArray?.data?[indexPath.row]
        if(data?.isApproved == 1){
            return 60
        }else{
            return 0
        }
    }
    
}
