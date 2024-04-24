//
//  ForgotPassword_VC.swift
//  HeavenlyHands-2
//
//  Created by Abdul Naffay on 16/01/2024.
//

import UIKit

class ForgotPassword_VC: UIViewController {
    @IBOutlet weak var EmailFld:UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func SendBtn(_ Sender:Any){
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let destination = storyboard.instantiateViewController(withIdentifier: "NewPassword_VC") as! NewPassword_VC
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
