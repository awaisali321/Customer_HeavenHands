//
//  AppDelegate.swift
//  HeavenlyHands-2
//
//  Created by Abdul Naffay on 10/01/2024.
//

import UIKit
import IQKeyboardManagerSwift
import CoreData
import Foundation
import AVFoundation
import Firebase
import FirebaseMessaging
import FirebaseCore
import FirebaseAuth

import UserNotifications


@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var UserModel:CurrentUser? = nil
    var ProfileArray:ProfileModel? = nil
    var notificationArray: [notificationmodel]? {didSet {}}
 
    let gcmMessageIDKey = "gcm.message_id"
    var fcmtoken = String()
    let imagebaseurl = ""
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        IQKeyboardManager.shared.enable = true
                IQKeyboardManager.shared.shouldResignOnTouchOutside = true
                IQKeyboardManager.shared.shouldPlayInputClicks = true
                IQKeyboardManager.shared.shouldShowToolbarPlaceholder = false
                IQKeyboardManager.shared.enableDebugging = true
        if (UserDefaults.standard.object(forKey: "islogin") as? Bool ?? false){
            self.GotoDashBoard()
        }else {
          
            self.gotoSignInVc()
        }
        
        
           
           FirebaseApp.configure()

              // [START set_messaging_delegate]
              Messaging.messaging().delegate = self
              // [END set_messaging_delegate]
              // Register for remote notifications. This shows a permission dialog on first run, to
              // show the dialog at a more appropriate time move this registration accordingly.
              // [START register_for_notifications]
              UNUserNotificationCenter.current().delegate = self
         

              let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
              UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: { _, _ in }
              )

              application.registerForRemoteNotifications()
           
        
        
        return true
    }
    
    // MARK: UISceneSession Lifecycle

    func gotoSignInVc(){
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
                
                        if let stView = storyboard.instantiateViewController(withIdentifier: "Login_VC") as? Login_VC {
                         
                            stView.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
                            let navigationController = UINavigationController(rootViewController: stView)
                            navigationController.isNavigationBarHidden = true
                            self.window?.rootViewController = navigationController
                            self.window?.makeKeyAndVisible()
                            
                        }
    }
    func GotoDashBoard(){
        let loginclass = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Main_VC") as! Main_VC
        let navController = UINavigationController(rootViewController: loginclass) // Integrate navigation controller programmatically if you want
        let appdelegate = UIApplication.shared.delegate as! AppDelegate
//        appdelegate.window?.rootViewController = navController
//        UIApplication.shared.windows.first?.rootViewController = navController
//        UIApplication.shared.windows.first?.makeKeyAndVisible()

        navController.isNavigationBarHidden = true
        self.window?.rootViewController = navController
        self.window?.makeKeyAndVisible()


    }

    
//    // MARK: UISceneSession Lifecycle
//    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
//        // Called when a new scene session is being created.
//        // Use this method to select a configuration to create the new scene with.
//        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
//    }
//
//    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
//        // Called when the user discards a scene session.
//        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
//        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
//    }
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "DownloadApp")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    
    func application(_ application: UIApplication,
                       didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
        // If you are receiving a notification message while your app is in the background,
        // this callback will not be fired till the user taps on the notification launching the application.
        // TODO: Handle data of notification
        // With swizzling disabled you must let Messaging know about the message, for Analytics
        // Messaging.messaging().appDidReceiveMessage(userInfo)
        // Print message ID.
        if let messageID = userInfo[gcmMessageIDKey] {
          print("Message ID: \(messageID)")
        }

        // Print full message.
        print(userInfo)
      }

      // [START receive_message]
      func application(_ application: UIApplication,
                       didReceiveRemoteNotification userInfo: [AnyHashable: Any]) async
        -> UIBackgroundFetchResult {
        // If you are receiving a notification message while your app is in the background,
        // this callback will not be fired till the user taps on the notification launching the application.
        // TODO: Handle data of notification
        // With swizzling disabled you must let Messaging know about the message, for Analytics
        // Messaging.messaging().appDidReceiveMessage(userInfo)
        // Print message ID.
        if let messageID = userInfo[gcmMessageIDKey] {
          print("Message ID: \(messageID)")
        }

        // Print full message.
        print(userInfo)

        return UIBackgroundFetchResult.newData
      }

      // [END receive_message]
      func application(_ application: UIApplication,
                       didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Unable to register for remote notifications: \(error.localizedDescription)")
      }

      // This function is added here only for debugging purposes, and can be removed if swizzling is enabled.
      // If swizzling is disabled then this function must be implemented so that the APNs token can be paired to
      // the FCM registration token.
     
    func application(application: UIApplication,
                     didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Messaging.messaging().apnsToken = deviceToken
        let firebaseAuth = Auth.auth()
        firebaseAuth.setAPNSToken(deviceToken, type: AuthAPNSTokenType.prod)
        
        Messaging.messaging().token { (token, error) in
            if let error = error {
                print("Error fetching remote instance ID: \(error.localizedDescription)")
            } else if let token = token {
                self.fcmtoken = token
                UserDefaults.standard.set(token , forKey: "Token2")
                print("Token is firebase \(token)")
            }
        }
    }
    }
   




let appdelegate = UIApplication.shared.delegate as! AppDelegate



extension AppDelegate: UNUserNotificationCenterDelegate {
  // Receive displayed notifications for iOS 10 devices.
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        print(notification)
     
        let userInfo = notification.request.content.userInfo
        
        print(userInfo)
        let noti_type  = userInfo["aps"] as? NSDictionary
        let alert  = noti_type?["alert"] as? NSDictionary
        print(alert)
        let date = Date()
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd h:mm a"
        let dateString = df.string(from: date)
        print(dateString)
        
        let trip = notificationmodel()
        trip.title = alert?["title"] as? String ?? ""
        trip.body = alert?["body"] as? String ?? ""
        trip.dates = dateString
        UserDefaults.standard.set(alert?["body"] as? String ?? "" , forKey: "appointtime")
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "notificationpopup"), object: nil)
        self.notificationArray = notificationmodel.readUserFromArchive()
        
      
        
      
        
        
        self.notificationArray?.append(trip)
        
        if notificationmodel.saveUserToArchive(notificationmodels: self.notificationArray ?? []){
            
        }
       
//        completionHandler([UNNotificationPresentationOptions.sound , UNNotificationPresentationOptions.alert , UNNotificationPresentationOptions.badge])
//
       
        switch UIApplication.shared.applicationState {

        case .active:
            if #available(iOS 15.0, *) {
//                completionHandler([UNNotificationPresentationOptions.sound , UNNotificationPresentationOptions.alert , UNNotificationPresentationOptions.badge])
                completionHandler([.banner, .sound])
                
            } else {
                // Fallback on earlier versions
                completionHandler([.banner, .sound])
            }
        default:
            if #available(iOS 15.0, *) {
                completionHandler([.banner, .sound])
            } else {
                // Fallback on earlier versions
                completionHandler([.banner, .sound])
            }
        }
      
    }

  func userNotificationCenter(_ center: UNUserNotificationCenter,
                              didReceive response: UNNotificationResponse) async {
    let userInfo = response.notification.request.content.userInfo

    // [START_EXCLUDE]
    // Print message ID.
    if let messageID = userInfo[gcmMessageIDKey] {
      print("Message ID: \(messageID)")
    }
    // [END_EXCLUDE]
    // With swizzling disabled you must let Messaging know about the message, for Analytics
    // Messaging.messaging().appDidReceiveMessage(userInfo)
    // Print full message.
    print(userInfo)
      let noti_type  = userInfo["aps"] as? NSDictionary
      let alert  = noti_type?["alert"] as? NSDictionary
      print(alert)
      let date = Date()
      let df = DateFormatter()
      df.dateFormat = "yyyy-MM-dd h:mm a"
      let dateString = df.string(from: date)
      print(dateString)
      
      let trip = notificationmodel()
      trip.title = alert?["title"] as? String ?? ""
      trip.body = alert?["body"] as? String ?? ""
      trip.dates = dateString
      UserDefaults.standard.set(alert?["body"] as? String ?? "" , forKey: "appointtime")
      NotificationCenter.default.post(name: NSNotification.Name(rawValue: "notificationpopup"), object: nil)
      self.notificationArray = notificationmodel.readUserFromArchive()
      
    
      
    
      
      
      self.notificationArray?.append(trip)
      
      if notificationmodel.saveUserToArchive(notificationmodels: self.notificationArray ?? []){
          
      }
     
  }
}

// [END ios_10_message_handling]
extension AppDelegate: MessagingDelegate {
  // [START refresh_token]
  func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
    print("Firebase registration token: \(String(describing: fcmToken))")
      UserDefaults.standard.set(fcmToken ?? "" , forKey: "Token2")

    let dataDict: [String: String] = ["token": fcmToken ?? ""]
    NotificationCenter.default.post(
      name: Notification.Name("FCMToken"),
      object: nil,
      userInfo: dataDict
    )
    // TODO: If necessary send token to application server.
    // Note: This callback is fired at each app startup and whenever a new token is generated.
  }

  // [END refresh_token]
}

