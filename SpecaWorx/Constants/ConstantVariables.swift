//
//  ConstantVariables.swift
//  SpecaWorx
//
//  Created by Anil Kumar on 17/05/19.
//  Copyright © 2019 Anil Kumar. All rights reserved.
//

import Foundation
import UIKit

struct rememberPasswordFlag {
    static var rememberMe = false
}

var token             = String()
var message           = String()
var statusMessage     = String()
var gender            = true
var profileQr         = String()
var qrUsername        = String()
var qrHolderName      = String()
var qrHolderPic       = String()
var qrholderAge       = String()
var qrHolderContact   = String()
var qrHolderGender    = String()
var qrHoldermedicine  = String()
var qrholderComments  = String()
var code              = String()
var userName          = String()
var contact           = String()
var holderName        = String()
var comments          = String()
var picture           = String()
var routingFlag       = false
var qrSearchFlag      = false
var inCompleteProfile = false
var welcomeFlag       = false
var editFlag          = false

extension UIViewController{
    func showConfirmAlert(title: String?, message: String?, buttonTitle: String, buttonStyle: UIAlertAction.Style, confirmAction: ((UIAlertAction) -> Void)?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: buttonTitle, style: buttonStyle, handler:confirmAction))
        present(alert, animated: true, completion: nil)
    }
}

var profileInfo : [String:[String:Any]] = [:]
var profiles : [String:[String:[Any]]] = [:]
var qrCode : [String:Any] = [:]
var profileComplete : Bool = false
var currentLogInMail: String = ""

struct profileInformation {
    static var name         = String()
    static var ContactNo    = String()
    static var profileImage : Data?
    static var holderName   = String()
    static var holderAge    = String()
    static var holdergender = String()
    static var medicine     = String()
    static var comments     = String()
    static var token        = String()
    static var qrCode       = String()
    static var qrImage      = UIImage()
}

struct qrHolderInformation {
    static var qrCode           = String()
    static var qrImage          : Data?
    static var qrUsername       = String()
    static var qrHolderName     = String()
    static var qrholderAge      = String()
    static var qrHolderContact  = String()
    static var qrHolderGender   = String()
    static var qrHoldermedicine = String()
    static var qrholderComments = String()
    static var qrHolderImage    = String()
}

struct qrSearch{
    static var code       = String()
    static var userName   = String()
    static var contact    = String()
    static var holderName = String()
    static var comments   = String()
    static var picture    = UIImage()
}

struct QRData {
    var codeString: String?
}


extension UIImage {
    func toString() -> String? {
        let data: Data? = self.pngData()
        return data?.base64EncodedString(options: .endLineWithLineFeed)
    }
}

extension String {
    func toImage() -> UIImage? {
        if let data = Data(base64Encoded: self, options: .ignoreUnknownCharacters){
            return UIImage(data: data)
        }
        return nil
    }
}

extension UIViewController{
    func matches(for regex: String, in text: String) -> [String] {
        do {
            let regex = try NSRegularExpression(pattern: regex)
            let results = regex.matches(in: text,
                                        range: NSRange(text.startIndex..., in: text))
            return results.map {
                String(text[Range($0.range, in: text)!])
            }
        } catch let error {
            //      print("invalid regex: \(error.localizedDescription)")
            return [error.localizedDescription]
        }
    }
}
