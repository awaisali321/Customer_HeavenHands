//
//  Services.swift
//  RGB
//
//  Created by usamaghalzai on 15/11/2021.
//  Copyright © 2021 usamaghalzai. All rights reserved.
//

import Moya
import Foundation
import AVFAudio
import UIKit
import SwiftyJSON
class APIServices{
    
    
    
    class  func createRequest(url: URL) -> URLRequest {
        var request = URLRequest(url: url, timeoutInterval: Double.infinity)
        let token = UserDefaults.standard.string(forKey:AppDefault.accessToken) ?? ""
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        return request
    }
    class func pretty_function(_ file: String = #file, function: String = #function, line: Int = #line) {
        
        let fileString: NSString = NSString(string: file)
        if Thread.isMainThread {
            print("file:\(fileString.lastPathComponent) function:\(function) line:\(line) [M]")
        } else {
            print("file:\(fileString.lastPathComponent) function:\(function) line:\(line) [T]")
        }
    }
    class func loginApi(email:String, password:String,completion:@escaping(APIResult<Userdata>)->Void){
        Provider.services.request(.loginApi(email: email, password: password)) { result in
            do{
                
                let User: Userdata = try result.decoded()
                
                AppDefault.currentUser = User.patient
                AppDefault.accessToken = User.token ?? ""
                //                AppDefault.userId = user.id
                
                completion(.success(User))
            }catch{
                print("-----Error------ \n",error)
                completion(.failure(error.customDescription))
            }
        }
    }
    
    class func TasksApi(completion:@escaping(APIResult<TasksModel>)->Void){
        Provider.services.request(.TasksApi) { result in
            do{
                
                let User: TasksModel = try result.decoded()
                
                
                completion(.success(User))
            }catch{
                print("-----Error------ \n",error)
                completion(.failure(error.customDescription))
            }
        }
    }
    
    class func ReportsApi(completion:@escaping(APIResult<ReportsModel>)->Void){
        Provider.services.request(.ReportsApi) { result in
            do{
                
                let User: ReportsModel = try result.decoded()
                
                
                completion(.success(User))
            }catch{
                print("-----Error------ \n",error)
                completion(.failure(error.customDescription))
            }
        }
    }
    class func notificationapi(completion:@escaping(APIResult<Bool>)->Void){
        Provider.services.request(.notificationapi) { result in
            do{
                
                let User: Bool = try result.decoded()
                
                
                completion(.success(User))
            }catch{
                print("-----Error------ \n",error)
                completion(.failure(error.customDescription))
            }
        }
    }
    
    
    class func DocumentsApi(completion:@escaping(APIResult<DocumentsModel>)->Void){
        Provider.services.request(.DocumentsApi) { result in
            do{
                
                let User: DocumentsModel = try result.decoded()
                
                
                completion(.success(User))
            }catch{
                print("-----Error------ \n",error)
                completion(.failure(error.customDescription))
            }
        }
    }
    
    class func AppointmentsApi(completion:@escaping(APIResult<AppointmentsModel>)->Void){
        Provider.services.request(.AppointmentsApi) { result in
            do{
                
                let User: AppointmentsModel = try result.decoded()
                
                
                completion(.success(User))
            }catch{
                print("-----Error------ \n",error)
                completion(.failure(error.customDescription))
            }
        }
    }
    
    class func LogOutApi(completion:@escaping(APIResult<LogOutModel>)->Void){
        Provider.services.request(.LogOutApi) { result in
            do{
                
                let User: LogOutModel = try result.decoded()
                
                
                completion(.success(User))
            }catch{
                print("-----Error------ \n",error)
                completion(.failure(error.customDescription))
            }
        }
    }
    
    class func ProfileApi(first_name:String , last_name: String, date_of_birth: String, gender: String, email: String, cnic: String, ssn: String, mobile_number: String, home_number: String, street_address: String, city: String, state: String, img: Data, zip_code: String,completion:@escaping(APIResult<ProfileModel>)->Void){
        Provider.services.request(.ProfileApi(first_name:first_name , last_name: last_name, date_of_birth: date_of_birth, gender: gender, email: email, cnic: cnic, ssn: ssn, mobile_number: mobile_number, home_number: home_number, street_address: street_address, city: city, state: state, zip_code: zip_code, Image: img)) { result in
            do{
                
                let User: ProfileModel = try result.decoded()
                
                
                completion(.success(User))
            }catch{
                print("-----Error------ \n",error)
                completion(.failure(error.customDescription))
            }
            
            
        }
    }
    class func uploadImage(reportid: String, image: Data, completion: @escaping(APIResult<Bool>) -> Void) {
            Provider.services.request(.uploadImage(image: image, reportid: reportid)) { result in
                do {
                    let response: Bool = try result.decoded()
                    completion(.success(response))
                } catch {
                    print("-----Error------ \n", error)
                    completion(.failure(error.customDescription))
                }
            }
        }
    class func uploadprofile(reportid: String, image: Data, completion: @escaping(APIResult<Bool>) -> Void) {
            Provider.services.request(.uploadprofile(image: image, reportid: reportid)) { result in
                do {
                    let response: Bool = try result.decoded()
                    completion(.success(response))
                } catch {
                    print("-----Error------ \n", error)
                    completion(.failure(error.customDescription))
                }
            }
        }
}
