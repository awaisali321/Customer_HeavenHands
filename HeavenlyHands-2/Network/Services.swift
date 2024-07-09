////
////  Services.swift
////  RGB
////
////  Created by usamaghalzai on 15/11/2021.
////  Copyright © 2021 usamaghalzai. All rights reserved.
////
//
//import Foundation
//import Moya
//
//enum Services {
//    //MARK: - AUTHENTICATION
//    case loginApi(email:String,password:String)
//    case TasksApi
//    case ReportsApi
//    case DocumentsApi
//    case AppointmentsApi
//    case LogOutApi
//    case ProfileApi(first_name:String,last_name:String,date_of_birth:String,gender:String,email:String,cnic:String,ssn:String,mobile_number:String,home_number:String,street_address:String,city:String,state:String,zip_code:String)
//
//
//}
//
//extension Services: TargetType, AccessTokenAuthorizable {
//    
//    var baseURL: URL {
//        switch self {
////        case .loginApi:
////            return AppConstants.API.baseURL
//            
//        default:
//            return AppConstants.API.baseURL
//        }
//        
//    }
//    
//    var path: String {
//        switch self {
//        case .loginApi:
//            return "auth/login"
//        case .TasksApi:
//            return "patient/tasks"
//        case .ReportsApi:
//            return "patient/reports"
//        case .DocumentsApi:
//            return "patient/documents"
//        case .AppointmentsApi:
//            return "patient/appointments"
//        case .LogOutApi:
//            return "auth/logout"
//        case .ProfileApi:
//            return "patient/profile"
//            
//        default:
//            return ""
//            
//        }
//    
//    }
//    
//    var method: Moya.Method {
//        switch self {
//        case .TasksApi:
//            return .get
//        case .ReportsApi:
//            return .get
//        case .DocumentsApi:
//            return .get
//        case .AppointmentsApi:
//            return .get
////
//            
//        default:
//            return .post
//        }
//    }
//    
//    var sampleData: Data {
//        return Data()
//    }
//    
//    var task: Task {
//        switch self {
//        
//        case let .loginApi(email,password):
//            return .requestParameters(parameters: ["email": email,"password": password], encoding: JSONEncoding.default)
//          
//        case let .ProfileApi(first_name,last_name,date_of_birth,gender,email,cnic,ssn,mobile_number,home_number,street_address,city,state,zip_code):
//            return .requestParameters(parameters: ["first_name" : first_name,"last_name":last_name,"date_of_birth":date_of_birth,"gender":gender,"email":email,"cnic":cnic,"ssn":ssn,"mobile_number":mobile_number,"home_number":home_number,"street_address":street_address,"city":city,"state":state,"zip_code":zip_code], encoding: JSONEncoding.default)
//            
//            
//            
//            
//        default:
//            return .requestPlain
//        }
//    }
//    
//    
//    var headers: [String: String]? {
//        switch self{
////        case .TasksApi:
////            return [
////
////                "Content-Type": "application/json",
////                "Authorization": AppDefault.accessToken,
////                "Accept": "*/*",
////                "Retry-After": "3600"
////
////            ]
//            
//        default:  return [
//            "Content-Type": "application/json",
////            "Authorization": AppDefault.accessToken,
////            "Accept": "*/*",
////            "Retry-After": "3600"
//        ]
//            
//        }
//        
//        
//    }
//    
//    var authorizationType: AuthorizationType {
//        switch self{
//        case .TasksApi:
//            return .bearer
//        case .ReportsApi:
//            return .bearer
//        case .DocumentsApi:
//            return .bearer
//        case .AppointmentsApi:
//            return .bearer
//        case .LogOutApi:
//            return .bearer
//        case .ProfileApi:
//            return .bearer
//            
//        default:
//            return .none
//        }
//    }
//    
//    var validationType: ValidationType{
//        return .successCodes
//    }
//}


import Foundation
import Moya

enum Services {
    // MARK: - AUTHENTICATION
    case loginApi(email: String, password: String)
    case TasksApi
    case ReportsApi
    case DocumentsApi
    case AppointmentsApi
  case notificationapi
    case LogOutApi
    case ProfileApi(first_name: String, last_name: String, date_of_birth: String, gender: String, email: String, cnic: String, ssn: String, mobile_number: String, home_number: String, street_address: String, city: String, state: String, zip_code: String,Image: Data?)
    case uploadImage(image: Data,reportid: String)
    case uploadprofile(image: Data,reportid: String)
}

extension Services: TargetType, AccessTokenAuthorizable {

    var baseURL: URL {
        return AppConstants.API.baseURL
    }

    var path: String {
        switch self {
        case .loginApi:
            return "auth/login"
        case .TasksApi:
            return "patient/tasks"
        case .ReportsApi:
            return "patient/reports"
        case .DocumentsApi:
            return "patient/documents"
        case .AppointmentsApi:
            return "patient/appointments"
        case .LogOutApi:
            return "auth/logout"
        case .ProfileApi:
            return "patient/profile"
        case .notificationapi:
            return "fcm-token"
        case let .uploadImage(_,reportid):
            return "\(reportid)/report_signature"
        case let .uploadprofile(_,reportid):
            return "patient/profile"
           
       
        }
    }

    var method: Moya.Method {
        switch self {
        case .TasksApi, .ReportsApi, .DocumentsApi, .AppointmentsApi:
            return .get
        default:
            return .post
        }
    }

    var sampleData: Data {
        return Data()
    }

    var task: Task {
        switch self {
        case let .loginApi(email, password):
            return .requestParameters(parameters: ["email": email, "password": password], encoding: JSONEncoding.default)
        case  .notificationapi:
            return .requestParameters(parameters: ["fcm_token": (UserDefaults.standard.object(forKey: "Token2") as? String ?? "")], encoding: JSONEncoding.default)
        case let .ProfileApi(first_name, last_name, date_of_birth, gender, email, cnic, ssn, mobile_number, home_number, street_address, city, state, zip_code, img):
                    var multipartData = [MultipartFormData]()
                    let parameters = [
                        "first_name": first_name,
                        "last_name": last_name,
                        "date_of_birth": date_of_birth,
                        "gender": gender,
                        "email": email,
                        "cnic": cnic,
                        "ssn": ssn,
                        "mobile_number": mobile_number,
                        "home_number": home_number,
                        "street_address": street_address,
                        "city": city,
                        "state": state,
                        "zip_code": zip_code
                    ]

                    for (key, value) in parameters {
                        if let data = value.data(using: .utf8) {
                            multipartData.append(MultipartFormData(provider: .data(data), name: key))
                        }
                    }

                  
            let imageFormData = MultipartFormData(provider: .data(img!), name: "file", fileName: "file.png", mimeType: "image/png")
                        multipartData.append(imageFormData)
                    

                    return .uploadMultipart(multipartData)
        case let .uploadImage(images,_):
           
            let multipartData = MultipartFormData(provider: .data(images), name: "signature", fileName: "signature.png", mimeType: "image/png")
            return .uploadMultipart([multipartData])
        case let .uploadprofile(images,_):
           
            let multipartData = MultipartFormData(provider: .data(images), name: "File", fileName: "File.png", mimeType: "image/png")
            return .uploadMultipart([multipartData])
        default:
            return .requestPlain
        }
    }

    var headers: [String: String]? {
        switch self {
        default:
            return [
                "Content-Type": "application/json",
                // "Authorization": AppDefault.accessToken,
                // "Accept": "*/*",
                // "Retry-After": "3600"
            ]
        }
    }

    var authorizationType: AuthorizationType {
        switch self {
        case .TasksApi, .ReportsApi, .DocumentsApi, .AppointmentsApi, .LogOutApi, .ProfileApi, .uploadImage ,.uploadprofile ,.notificationapi:
            return .bearer
        default:
            return .none
        }
    }

    var validationType: ValidationType {
        return .successCodes
    }
}
