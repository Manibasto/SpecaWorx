//
//  QRScannerScreenController.swift
//  SpecaWorx
//
//  Created by Anil Kumar on 22/05/19.
//  Copyright © 2019 Anil Kumar. All rights reserved.
//

import UIKit

class QRScannerScreenController: UIViewController {
    
    lazy var appLogo          = customImageClass()
    lazy var topView          = customUIViewClass()
    lazy var welcomeView      = customUIViewClass()
    lazy var signUpView       = customUIViewClass()
    var j = 0
    var k = Int()
    
    private let menuBack      = UIButtonFactory(title: "")
        .backgroundImage(with: UIImage(named: "back-icon")!)
        .addTarget(self, action: #selector(menuBackTapped), for: .touchUpInside)
        .build()
    
    private let titleLabel    = UILabelFactory(text: "SCAN QR")
        .numberOf(lines: 0)
        .textAlignment(with: .left)
        .textColor(with: .white)
        .fontSize(of: 18.0)
        .build()
    
    private let signUpLabel   = UILabelFactory(text: "Scan QR Code")
        .numberOf(lines: 0)
        .textAlignment(with: .center)
        .textColor(with: .white)
        .fontSize(of: 15.0)
        .build()
    
    var scannerView    = QRScannerView() {
        didSet {
            scannerView.delegate = self
        }
    }
    
    var qrData: QRData? = nil {
        didSet {
            if qrData != nil {
                if let str = qrData?.codeString {
                    let strArray = Array(str)
                    for i in 0..<(strArray.count) where strArray[i] == "{" {
                        let last =  str.suffix(from: str.endIndex)
                        let finalStr = str.substring(from: i, to: Int(last))
                        print(finalStr)
                        let data = finalStr.data(using: .utf8)!
                        do {
                            if let jsonArray = try JSONSerialization.jsonObject(with: data, options : .allowFragments) as? [String:Any]
                            {
                                let value = ModalData(JSON: jsonArray)
                                qrSearchFlag = true
                                userDetail.holder_name = value.holder_name
                                userDetail.name        = value.name
                                userDetail.contact     = value.contact
                                userDetail.coder       = String(value.coder!)
                                let url = URL(string:value.picture!)
                                if let data = try? Data(contentsOf: url!)
                                {
                                    userDetail.picture = UIImage(data: data)!
                                }
                                
                            } else {
                                print("bad json")
                            }
                        } catch let error as NSError {
                            print(error)
                        }
                    }
                }
                if welcomeFlag{
                    welcomeFlag = false
                    navigationController?.popViewController(animated: true)
                }else{
                    let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ScanResultScreenController") as? ScanResultScreenController
                    self.navigationController?.pushViewController(vc!, animated: true)
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        scannerView.delegate         = self
        appLogo.image                = UIImage(named: "specaworx-logo")
        view.backgroundColor         = UIColor.black.withAlphaComponent(0.5)
        topView.backgroundColor      = .white
        welcomeView.backgroundColor  = UIColor(red: 40/255, green: 92/255, blue: 148/255, alpha: 1.0)
        signUpView.backgroundColor   = UIColor(red: 50/255, green: 113/255, blue: 180/255, alpha: 1.0)
        view.addSubview(topView)
        topView.addSubview(appLogo)
        view.addSubview(welcomeView)
        view.addSubview(signUpView)
        signUpView.addSubview(signUpLabel)
        welcomeView.addSubview(menuBack)
        welcomeView.addSubview(titleLabel)
        view.addSubview(scannerView)
        
        setUpConstraintsForLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if !scannerView.isRunning {
            scannerView.startScanning()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        if !scannerView.isRunning{
            scannerView.stopScanning()
        }
    }
    
    @objc func menuBackTapped(){
        self.navigationController?.popViewController(animated: true)
    }
    
    func setUpConstraintsForLayout(){
        switch UIDevice().type {
        case .iPhoneX,.iPhoneXS,.iPhoneXSmax,.iPhoneXR:
            topView.layoutAnchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, centerX: nil, centerY: nil, paddingTop: 0.0, paddingLeft: 0.0, paddingBottom: 0.0, paddingRight: 0.0, width: 0.0, height: 100, enableInsets: true)
            appLogo.layoutAnchor(top: topView.topAnchor, left: nil, bottom: nil, right: nil, centerX: topView.centerXAnchor, centerY: nil, paddingTop: 65.0, paddingLeft: 0.0, paddingBottom: 0.0, paddingRight: 0.0, width: 150.0, height: 30.0, enableInsets: true)
        default:
            topView.layoutAnchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, centerX: nil, centerY: nil, paddingTop: 0.0, paddingLeft: 0.0, paddingBottom: 0.0, paddingRight: 0.0, width: 0.0, height: 80, enableInsets: true)
            appLogo.layoutAnchor(top: topView.topAnchor, left: nil, bottom: nil, right: nil, centerX: topView.centerXAnchor, centerY: nil, paddingTop: 40.0, paddingLeft: 0.0, paddingBottom: 0.0, paddingRight: 0.0, width: 150.0, height: 30.0, enableInsets: true)
        }
        welcomeView.layoutAnchor(top: appLogo.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, centerX: nil, centerY: nil, paddingTop: 0.0, paddingLeft: 0.0, paddingBottom: 0.0, paddingRight: 0.0, width: 0.0, height: 50.0, enableInsets: true)
        menuBack.layoutAnchor(top: welcomeView.topAnchor, left: welcomeView.leftAnchor, bottom: welcomeView.bottomAnchor, right: nil, centerX: nil, centerY: nil, paddingTop: 0.0, paddingLeft: 0.0, paddingBottom: 0.0, paddingRight: 0.0, width: 50.0, height: 0.0, enableInsets: true)
        titleLabel.layoutAnchor(top: nil, left: menuBack.rightAnchor, bottom: nil, right: nil, centerX: nil, centerY: menuBack.centerYAnchor, paddingTop: 0.0, paddingLeft: 10.0, paddingBottom: 0.0, paddingRight: 0.0, width: 0.0, height: 0.0, enableInsets: true)
        signUpView.layoutAnchor(top: welcomeView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, centerX: nil, centerY: nil, paddingTop: 0.0, paddingLeft: 0.0, paddingBottom: 0.0, paddingRight: 0.0, width: 0.0, height: 60.0, enableInsets: true)
        signUpLabel.layoutAnchor(top: nil, left: nil, bottom: nil, right: nil, centerX: signUpView.centerXAnchor, centerY: signUpView.centerYAnchor, paddingTop: 0.0, paddingLeft: 0.0, paddingBottom: 0.0, paddingRight: 0.0, width: 0.0, height: 0.0, enableInsets: true)
        scannerView.layoutAnchor(top: nil, left: nil, bottom: nil, right: nil, centerX: view.centerXAnchor, centerY: view.centerYAnchor, paddingTop: 0.0, paddingLeft: 0.0, paddingBottom: 0.0, paddingRight: 0.0, width: view.frame.size.width/2, height: view.frame.size.height/4, enableInsets: true)
    }
}

extension QRScannerScreenController: QRScannerViewDelegate{
    func qrScanningDidFail() {
        showConfirmAlert(title: "", message: "QR Scanning Failed", buttonTitle: "Dismiss", buttonStyle: .default) { (action) in
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func qrScanningSucceededWithCode(_ str: String?) {
        self.qrData = QRData(codeString: str)
    }
    
    func qrScanningDidStop() {
    }
}

extension String {
    func substring(from: Int?, to: Int?) -> String {
        if let start = from {
            guard start < self.count else {
                return ""
            }
        }
        
        if let end = to {
            guard end >= 0 else {
                return ""
            }
        }
        
        if let start = from, let end = to {
            guard end - start >= 0 else {
                return ""
            }
        }
        
        let startIndex: String.Index
        if let start = from, start >= 0 {
            startIndex = self.index(self.startIndex, offsetBy: start)
        } else {
            startIndex = self.startIndex
        }
        
        let endIndex: String.Index
        if let end = to, end >= 0, end < self.count {
            endIndex = self.index(self.startIndex, offsetBy: end + 1)
        } else {
            endIndex = self.endIndex
        }
        
        return String(self[startIndex ..< endIndex])
    }
    
    func substring(from: Int) -> String {
        return self.substring(from: from, to: nil)
    }
    
    func substring(to: Int) -> String {
        return self.substring(from: nil, to: to)
    }
    
    func substring(from: Int?, length: Int) -> String {
        guard length > 0 else {
            return ""
        }
        
        let end: Int
        if let start = from, start > 0 {
            end = start + length - 1
        } else {
            end = length - 1
        }
        
        return self.substring(from: from, to: end)
    }
    
    func substring(length: Int, to: Int?) -> String {
        guard let end = to, end > 0, length > 0 else {
            return ""
        }
        
        let start: Int
        if let end = to, end - length > 0 {
            start = end - length + 1
        } else {
            start = 0
        }
        
        return self.substring(from: start, to: to)
    }
}

extension String{
    func toDictionary() -> NSDictionary {
        let blankDict : NSDictionary = [:]
        if let data = self.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as! NSDictionary
            } catch {
                print(error.localizedDescription)
            }
        }
        return blankDict
    }
}

extension String {
    func toJSON() -> Any? {
        guard let data = self.data(using: .utf8, allowLossyConversion: false) else { return nil }
        return try? JSONSerialization.jsonObject(with: data, options: .mutableContainers)
    }
    
    mutating func add(prefix: String) {
        self = prefix + self
    }
}

struct userDetail {
    static var id : Int?
    static var name : String?
    static var holder_name : String?
    static var user_id : Int?
    static var holder_age : String?
    static var gender : String?
    static var contact : String?
    static var coder : String?
    static var picture : UIImage?
}

struct ModalData {
    var id : Int?
    var name : String?
    var holder_name : String?
    var user_id : Int?
    var holder_age : String?
    var gender : String?
    var contact : String?
    var coder : Int?
    var picture : String?
    
    init(JSON: [String:Any]){
        self.id = JSON["id"] as? Int
        self.name = JSON["name"] as? String
        self.holder_name = JSON["holder_name"] as? String
        self.user_id = JSON["user_id"] as? Int
        self.holder_age = JSON["holder_age"] as? String
        self.gender = JSON["gender"] as? String
        self.contact = JSON["contact"] as? String
        self.coder = JSON["coder"] as? Int
        self.picture = JSON["picture"] as? String
    }
}
