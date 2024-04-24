//
//  Tasks_VC.swift
//  HeavenlyHands-2
//
//  Created by Abdul Naffay on 10/01/2024.
//

import UIKit

class Tasks_VC: UIViewController {
    @IBOutlet weak var TasksTbl:UITableView!
    var ReportNamesArray = [String]()
    var TimeArray = [String]()
    var taskmodelArray:TasksModel? {
        didSet{
            TasksTbl.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.TasksApi()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        TasksTbl.dataSource = self
        TasksTbl.delegate = self
        ReportNamesArray = ["Report Name 1","Report Name 2","Report Name 3","Report Name 4","Report Name 5","Report Name 6"]
        TimeArray = ["10:15 pm","10:20 pm","10:30 pm","10:35 pm","10:40 pm","10:50 pm"]
    }
    private  func TasksApi() {
        APIServices.TasksApi() {(result) in
            switch result{
            case .success(let response):
                self.taskmodelArray = response
                
                if (response.data?.isEmpty == true){
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
    @IBAction func btn_open_menu(_ Sender:Any){
        self.sideMenuController?.toggle()

    }
    @objc func AddSignatureButton(sender: UIButton){
        let data = taskmodelArray?.data?[sender.tag]
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let destination = storyboard.instantiateViewController(withIdentifier: "AddSignature_VC") as! AddSignature_VC
        
        destination.taskmodelArray = taskmodelArray
        destination.PathLbl = taskmodelArray?.path ?? ""
        
        navigationController?.pushViewController(destination, animated: true)
        dismiss(animated: true, completion: nil)
        
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
extension Tasks_VC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskmodelArray?.data?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = TasksTbl.dequeueReusableCell(withIdentifier: "TasksVC_Cell", for: indexPath)as!
        TasksVC_Cell
        let data = taskmodelArray?.data?[indexPath.row]
        cell.ReportNameLbl.text = data?.title
        cell.timelbl.text = data?.createdAt?.pToDate()?.getFormattedDate(format: "dd-MM-yyyy")
        cell.AddSignatureBtn.tag = indexPath.row
        cell.AddSignatureBtn.addTarget(self, action: #selector(AddSignatureButton(sender:)), for: .touchUpInside)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    
}

