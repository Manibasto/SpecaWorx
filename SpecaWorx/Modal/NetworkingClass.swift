//
//  NetworkingClass.swift
//  SpecaWorx
//
//  Created by Anil Kumar on 17/05/19.
//  Copyright © 2019 Anil Kumar. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class Networking: NSObject{
    
    public static let shared = Networking()
    
    
    func signUpVerification(_ email: String,_ password: String, _ confirmPassword: String, completion: @escaping(_ success:Bool, _ error:String, _ result: String, _ token:String) -> Void ){
        
        APIManager.sharedManager.request("\(URLConstant.signUpUrl)email=\(email)&password=\(password)&conform_password=\(confirmPassword)", method: .post, parameters: ["":""], encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            switch (response.result){
            case .success(_):
                var data = [String:Any]()
                if let result : [String:Any] = response.result.value as? [String : Any]{
                    for _ in result{
                        message = result["message"] as! String
                        if message == "The email has already been taken."{
                            completion(false, "The email has already been taken.","","")
                            return
                        }else if message == "The password format is invalid."{
                            completion(false, "Password format is Incorrect","","")
                            return
                        }
                        data   = result["data"] as! [String:Any]
                    }
                    for _ in data{
                        token = data["api_token"] as! String
                    }
                    print("token---->", token)
                    completion(true,"" , message, token)
                }
            case .failure(let error):
                completion(false, error.localizedDescription, "error", "")
            }
        }
    }
    
    func signInVerification(_ email: String,_ password: String, completion: @escaping(_ success:Bool, _ error:String, _ result: String, _ token: String, _ userInfo: Bool, _ username: String, _ contact: String, _ holderName: String, _ age: String, _ gender: String, _ medicine: String, _ comments: String, _ picture: String, _ qrCode: String) -> Void ){
        
        APIManager.sharedManager.request("\(URLConstant.signInUrl)email=\(email)&password=\(password)", method: .post, parameters: ["":""], encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            switch (response.result){
            case .success(_):
                var data = [String:Any]()
                var userId: Bool!
                var medicines = String()
                var comments = String()
                if let result : [String:Any] = response.result.value as? [String : Any]{
                    for _ in result{
                        statusMessage = result["message"] as! String
                    }
                    if statusMessage == "Email or password is incorrect."{
                        completion(false, "Email or password is incorrect.","","",false, "", "", "", "", "", "", "", "", "")
                        return
                    }else{
                        data          = result["data"] as! [String:Any]
                    }
                    print(data)
                    for _ in data{
                        token = data["api_token"] as! String
                        if let _ = data["user_id"]{
                            userId = true
                        }else{
                            userId = false
                        }
                    }
                    if !userId{
                        completion(true,"" , statusMessage, token, false, "", "", "", "", "" , "", "", "", "")
                    }else{
                        let userName = data["user_name"] as! String
                        let user_contact = data["user_contact"] as! String
                        let holder_name = data["holder_name"] as! String
                        let holder_age = data["holder_age"] as! String
                        let profile_picture = data["profile_picture"] as! String
                        let gender = data["gender"] as! String
                        let profile_qr = data["profile_qr"] as! String
                        if let medicine = data["medicines"]{
                            medicines = medicine as? String ?? "No Medicine Information"
                        }
                        if let comment = data["comments"]{
                            comments = comment as? String ?? "No Comments"
                        }
                        completion(true,"" , statusMessage, token, true, userName, user_contact, holder_name, holder_age, gender, medicines, comments, profile_picture, profile_qr)
                    }
                    print("token---->",token)
                }
            case .failure(let error):
                completion(false, error.localizedDescription, "error", "", false, "", "", "", "", "", "", "", "", "")
            }
        }
    }
    
    func profileSetUp(user_name: String, user_contact: String, picture: Data, holder_name: String , holder_age: String, gender: String, medicines: String, comments: String, api_token: String, completion: @escaping(_ success:Bool, _ error:String, _ result: String, _ token: String,_ username: String, _ contact: String, _ holderName: String, _ age: String, _ gender: String, _ medicine: String, _ comments: String, _ picture: String) -> Void){
        let parameters = [
            "user_name": user_name,
            "user_contact": user_contact,
            "holder_name": holder_name,
            "holder_age": holder_age,
            "gender": gender,
            "medicines": medicines,
            "comments": medicines,
            "api_token": api_token
        ]
        
        APIManager.sharedManager.upload(multipartFormData: { (MultipartFormData) in
            for (key, value) in parameters{
                MultipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
            }
            MultipartFormData.append(picture, withName: "picture", fileName: "picture.png", mimeType: "picture/png")
        }, to: URLConstant.profileUrl) { (result) in
            switch result {
            case .success(request: let upload, _, _):
                upload.responseJSON { (response) in
                    var data = [String:Any]()
                    if let result : [String:Any] = response.result.value as? [String : Any]{
                        data = result["data"] as! [String:Any]
                    }
                    for _ in data{
                        token             = data["api_token"] as! String
                        profileQr         = data["profile_qr"] as! String
                        qrUsername        = data["user_name"] as! String
                        qrHolderContact   = data["user_contact"] as! String
                        qrHolderName      = data["holder_name"] as! String
                        qrHolderPic       = data["profile_picture"] as! String
                        qrholderAge       = data["holder_age"] as! String
                        qrHolderGender    = data["gender"] as! String
                        qrHoldermedicine  = data["medicines"] as! String
                        qrholderComments  = data["comments"] as! String
                    }
                    print(profileQr)
                    completion(true, "", profileQr, token, qrUsername, qrHolderContact, qrHolderName, qrholderAge, qrHolderGender, qrHoldermedicine, qrholderComments, qrHolderPic)
                }
            case .failure(let error):
                completion(true, error.localizedDescription, "", "", "", "", "", "", "", "", "","")
            }
        }
    }
    
    func qrSearch(_ code:String, _ api_token:String, completion: @escaping(_ success:Bool, _ error:String, _ result: String, _ token:String,_ username:String, _ contact:String, _ holderName: String, _ picture:String, _ comments:String) -> Void){
        APIManager.sharedManager.request("\(URLConstant.qrSearchUrl)code=\(code)", method: .post, parameters: ["":""], encoding: URLEncoding.default, headers: nil).responseJSON{ (response) in
            switch (response.result){
            case .success(_):
                var data = [String:Any]()
                if let result : [String:Any] = response.result.value as? [String : Any]{
                    for _ in result{
                        data = result["data"] as! [String:Any]
                    }
                    
                    for _ in data{
//                        token             = data["api_token"] as! String
                        userName          = data["user_name"] as! String
                        contact           = data["user_contact"] as! String
                        holderName        = data["holder_name"] as! String
                        if let comments1  = data["comments"] as? String{
                            comments      = comments1
                        }else{
                            comments = "No data"
                        }
                        picture           = data["profile_picture"] as! String
                    }
                    completion(true, "", "success", "", userName, contact, holderName, picture, comments)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

struct APIManager {
    static let sharedManager: SessionManager = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 30
        return Alamofire.SessionManager(configuration: configuration)
    }()
}

struct URLConstant{
    static let signUpUrl  = "http://specaworx.aitechdemos.com/public/api/register?"
    static let signInUrl  = "http://specaworx.aitechdemos.com/public/api/login?"
    static let profileUrl = "http://specaworx.aitechdemos.com/public/api/qr/holder"
    static let qrSearchUrl = "http://specaworx.aitechdemos.com/public/api/show/QRcode?"
}
