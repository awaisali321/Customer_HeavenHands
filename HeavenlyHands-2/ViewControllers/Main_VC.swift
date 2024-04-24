//
//  Main_vc.swift
//  HeavenlyHands-2
//
//  Created by Abdul Naffay on 10/01/2024.
//

    import UIKit
    import SideMenuController

    class Main_VC: SideMenuController {
        required init?(coder aDecoder: NSCoder) {
            
            
            SideMenuController.preferences.drawing.menuButtonImage = UIImage(named: "SideMenuicon")
            SideMenuController.preferences.drawing.sidePanelPosition = .overCenterPanelLeft
            SideMenuController.preferences.drawing.sidePanelWidth = 300
            
            SideMenuController.preferences.drawing.centerPanelShadow = true
            
            SideMenuController.preferences.animating.statusBarBehaviour = .showUnderlay
            
//            SideMenuManager.default.menuFadeStatusBar = false
            

            super.init(coder: aDecoder)
            
        }
        
        var Segue = ""
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
    //        ActivityIndicatorSingleton.StopActivity(myView: self.view)
    //
    //        print("segue is \(Segue)")
    //        //self.StatusChecking()
    //       // self.Segue = (UserDefaults.standard.string(forKey: "Status") ?? "False")
    //        let status =  "\(UserDefaults.standard.string(forKey: "Status") ?? "0")"
    //
    //        print("status is \(status)")
    //        if status == "1"
    //
            
            self.performSegue(withIdentifier: "MenuHomeVC", sender: nil)
            self.performSegue(withIdentifier: "SideMenu", sender: nil)
            // Do any additional setup after loading the view.
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

