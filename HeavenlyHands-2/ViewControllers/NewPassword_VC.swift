//
//  NewPassword_VC.swift
//  HeavenlyHands-2
//
//  Created by Abdul Naffay on 16/01/2024.
//

import UIKit

class NewPassword_VC: UIViewController {
    @IBOutlet weak var PasswordFld:UITextField!
    @IBOutlet weak var ConfirmPasswordFld:UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func SaveBtn(_ Sender:Any){
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let destination = storyboard.instantiateViewController(withIdentifier: "Login_VC") as! Login_VC
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
