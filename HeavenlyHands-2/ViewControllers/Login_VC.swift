//
//  Login_VC.swift
//  HeavenlyHands-2
//
//  Created by Abdul Naffay on 16/01/2024.
//

import UIKit

class Login_VC: UIViewController {
    @IBOutlet weak var UserNameFld:UITextField!
    @IBOutlet weak var PasswordFld:UITextField!
    @IBOutlet weak var rememberMe_button:UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        UserNameFld.text = "ios@mail.com"
//        PasswordFld.text = "12345678"
        // Do any additional setup after loading the view.
    }
    var modelLogin: Userdata? {
        didSet {
            if modelLogin?.token != "" {
                
                UserDefaults.standard.set(self.modelLogin?.token ?? "", forKey: "token")
                
            }
        }
    }
    
    @IBAction func ForgotPasswordBtn(_ Sender:Any){
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let destination = storyboard.instantiateViewController(withIdentifier: "ForgotPassword_VC") as! ForgotPassword_VC
        navigationController?.pushViewController(destination, animated: true)
        dismiss(animated: true, completion: nil)

    }
    @IBAction func LoginBtn(_ Sender:Any){
        if UserNameFld.text != "" {
            if PasswordFld.text != "" {
                UserDefaults.standard.set(true, forKey: "islogin")
                UserDefaults.standard.set(UserNameFld.text, forKey: "username")
                UserDefaults.standard.set(PasswordFld.text, forKey: "password")
                funLogin(UserNameFld.text!, PasswordFld.text!)
            }
        }else if(UserNameFld.text == "" || PasswordFld.text == ""){
            self.view.makeToast("Please Enter Your Credentials")
        }
//        else if(UserNameFld.text == ""){
//            self.view.makeToast("Please Enter Your Email")
//        }else if(PasswordFld.text == ""){
//            self.view.makeToast("Please Enter Your Password")
//        }
        

    }
    @IBAction func rememberMe_button(_ Sender:UIButton){
        rememberMe_button.isSelected = !rememberMe_button.isSelected
        if rememberMe_button.isSelected{
            UserDefaults.standard.set(true, forKey: "isremeber")

        }else{
            UserDefaults.standard.set(false, forKey: "isremeber")

        }
    }
    private  func funLogin(_ email: String, _ password: String) {
        APIServices.loginApi(email: email, password: password) {(result) in
            switch result{
            case .success(let response):
                
                appdelegate.GotoDashBoard()
               

            case .failure(let error):
                print(error)
                self.view.makeToast("Given Credentials Is Not Valid")
                
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
