//
//  Notifications_VC.swift
//  HeavenlyHands-2
//
//  Created by Abdul Naffay on 10/01/2024.
//

import UIKit

class Notifications_VC: UIViewController {
    @IBOutlet weak var NotificationTbl:UITableView!
    @IBOutlet weak var nodataview: UIView!
    var notificationArray: [notificationmodel]? {didSet {}}
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedNotification(notification:)), name: Notification.Name("notificationpopup"), object: nil)
        NotificationTbl.register(UINib(nibName: "NotificationCell", bundle: nil), forCellReuseIdentifier: "NotificationCell")
        NotificationTbl.delegate = self
        NotificationTbl.dataSource = self
        
        notificationArray = notificationmodel.readUserFromArchive()
        
        
        if(notificationArray?.count ?? 0 > 0){
            self.nodataview.isHidden = true
        }else{
            self.nodataview.isHidden = false
        }
        self.NotificationTbl.reloadData()
        
        // Do any additional setup after loading the view.
    }
    @objc func methodOfReceivedNotification(notification: Notification) {
        notificationArray = notificationmodel.readUserFromArchive()
        self.NotificationTbl.reloadData()
    }
    override func viewWillAppear(_ animated: Bool) {
        NotificationTbl.dataSource = self
        NotificationTbl.delegate = self
    }
    @IBAction func BackBtn(_ sender: Any) {
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
    func setdate(setdate:String,format:String)->String{
        
        
        
        
  
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        formatter.locale = Locale(identifier: "en_US_POSIX")
       
        
//
//        let formatter = DateFormatter()
//
//        formatter.dateFormat = "yyyy-MM-ddTHH:mm:ss.SSS ZZZZ"
        let result = formatter.date(from: setdate) ?? Date()
        
        let formatter2 = DateFormatter()
        formatter2.dateFormat = format
        let result3 = formatter2.string(from: result)
        

        return result3
        
    }
}
extension Notifications_VC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notificationArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationCell", for: indexPath) as! NotificationCell
        let data = notificationArray?[indexPath.row]
        cell.titlelbl.text = data?.title
        cell.body.text = data?.body
        cell.datelbl.text = self.setdate(setdate: data?.dates ?? "", format: "dd-MM-yyyy")
        
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
     
      
      
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
}
//
//  PatientsVC.swift
//  HEAVENLY_HANDS
//
//  Created by Subhan Ilyas on 16/01/2023.
//
