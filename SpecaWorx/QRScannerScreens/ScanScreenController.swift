//
//  ScanScreenController.swift
//  SpecaWorx
//
//  Created by Anil Kumar on 21/05/19.
//  Copyright © 2019 Anil Kumar. All rights reserved.
//

import UIKit

class ScanScreenController: UIViewController {
    
    lazy var appLogo          = customImageClass()
    lazy var welcomeView      = customUIViewClass()
    lazy var signUpView       = customUIViewClass()
    lazy var firstBGView      = customUIViewClass()
    lazy var secondBGView     = customUIViewClass()
    lazy var inputText        = TextField()
    lazy var buttonView       = customUIViewClass()
    let numberToolbar             = UIToolbar(frame:CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
    
//    private let menuBar       = UIButtonFactory(title: "")
//        .backgroundImage(with: UIImage(named: "mobile-menu")!)
//        //        .addTarget(self, action: #selector(menuButtonTapped), for: .touchUpInside)
//        .build()
    
    private let menuBack      = UIButtonFactory(title: "")
        .backgroundImage(with: UIImage(named: "back-icon")!)
        .addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        .build()
    
    private let titleLabel    = UILabelFactory(text: "SCAN")
        .numberOf(lines: 0)
        .textAlignment(with: .left)
        .textColor(with: .white)
        .fontSize(of: 18.0)
        .build()
    
    private let signUpLabel   = UILabelFactory(text: "Scan or Input Number")
        .numberOf(lines: 0)
        .textAlignment(with: .center)
        .textColor(with: .white)
        .fontSize(of: 15.0)
        .build()
    
    private let createProfile = UIButtonFactory(title: "SUBMIT")
        .backgroundColour(with: UIColor(red: 38/255, green: 87/255, blue: 140/255, alpha: 1.0))
        .textColor(with: .white)
        .textFontSize(with: UIFont(name: "Montserrat-Medium", size: 13.0)!)
        .borderColor(with: UIColor(red: 32/255, green: 76/255, blue: 120/255, alpha: 1.0).cgColor)
        .borderThick(with: 1.0)
        .cornerRadious(with: 25.0)
        .addTarget(self, action: #selector(submitButtonTapped), for: .touchUpInside)
        .build()
    
    private let qrLabel     = UILabelFactory(text: "Scan QR Code")
        .numberOf(lines: 0)
        .textAlignment(with: .center)
        .textColor(with: .white)
        .fontSize(of: 16.0)
        .build()
    
    private let qrButton      = UIButtonFactory(title: "")
        .backgroundImage(with: UIImage(named: "QRIcon")!)
        .addTarget(self, action: #selector(qrButtonTapped), for: .touchUpInside)
        .build()
    
    private let signIn        = UIButtonFactory(title: "Back")
        .textColor(with: .white)
        .textFonts(with: UIFont(name: "Montserrat-Medium", size: 12.0)!)
        //        .addTarget(self, action: #selector(signInButtonTapped), for: .touchUpInside)
        .build()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = true
        appLogo.image                = UIImage(named: "specaworx-logo")
        welcomeView.backgroundColor  = UIColor(red: 40/255, green: 92/255, blue: 148/255, alpha: 1.0)
        signUpView.backgroundColor   = UIColor(red: 50/255, green: 113/255, blue: 180/255, alpha: 1.0)
        firstBGView.backgroundColor  = UIColor(red: 50/255, green: 113/255, blue: 180/255, alpha: 1.0)
        secondBGView.backgroundColor = UIColor(red: 62/255, green: 138/255, blue: 222/255, alpha: 0.9)
        buttonView.backgroundColor   = UIColor(red: 58/255, green: 127/255, blue: 200/255, alpha: 1.0)
        inputText.borderStyle        = .line
        inputText.backgroundColor    = UIColor(red: 40/255, green: 92/255, blue: 148/255, alpha: 1.0)
        inputText.layer.borderColor  = UIColor(red: 73/255, green: 153/255, blue: 235/255, alpha: 1.0).cgColor
        inputText.textAlignment      = .center
        inputText.keyboardType       = .numberPad
        inputText.delegate           = self
        numberToolbar.barStyle = .default
        numberToolbar.items = [
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
            UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(didTabDoneBarButton))]
        numberToolbar.sizeToFit()
        inputText.inputAccessoryView = numberToolbar
        
        setUpLayoutViews()
        setUpConstraintsForLayout()
    }
    
    @objc func didTabDoneBarButton(){
        inputText.resignFirstResponder()
    }
    
    func setUpLayoutViews(){
        view.addSubview(appLogo)
//        view.addSubview(menuBar)
        view.addSubview(welcomeView)
        view.addSubview(signUpView)
        signUpView.addSubview(signUpLabel)
        welcomeView.addSubview(menuBack)
        welcomeView.addSubview(titleLabel)
        view.addSubview(firstBGView)
        firstBGView.addSubview(secondBGView)
        firstBGView.addSubview(createProfile)
        firstBGView.addSubview(signIn)
        secondBGView.addSubview(qrLabel)
        secondBGView.addSubview(buttonView)
        buttonView.addSubview(qrButton)
        buttonView.bringSubviewToFront(qrButton)
        secondBGView.addSubview(inputText)
    }
    
    @objc func qrButtonTapped(){
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "QRScannerScreenController") as? QRScannerScreenController
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    @objc func backButtonTapped(){
        navigationController?.popViewController(animated: true)
    }
    
    @objc func submitButtonTapped(){
        if Reachability.isConnectedToNetwork() {
            createProfile.loadingIndicator(show: true)
            createProfile.setTitle("", for: .normal)
            let validation =  validateTextFeilds()
            if validation {
                userInformation(qrSearch.code, profileInformation.token)
            }else{
                createProfile.loadingIndicator(show: false)
                createProfile.setTitle("", for: .normal)
            }
        }
    }
    
    func setUpConstraintsForLayout(){
        switch UIDevice().type {
        case .iPhoneX,.iPhoneXS,.iPhoneXSmax,.iPhoneXR:
            appLogo.layoutAnchor(top: view.topAnchor, left: nil, bottom: nil, right: nil, centerX: view.centerXAnchor, centerY: nil, paddingTop: 65.0, paddingLeft: 0.0, paddingBottom: 0.0, paddingRight: 0.0, width: 150.0, height: 30.0, enableInsets: true)
//            menuBar.layoutAnchor(top: nil, left: view.leftAnchor, bottom: nil, right: nil, centerX: nil, centerY: appLogo.centerYAnchor, paddingTop: 0.0, paddingLeft: 20.0, paddingBottom: 0.0, paddingRight: 0.0, width: 25.0, height: 25.0, enableInsets: true)
        default:
            appLogo.layoutAnchor(top: view.topAnchor, left: nil, bottom: nil, right: nil, centerX: view.centerXAnchor, centerY: nil, paddingTop: 40.0, paddingLeft: 0.0, paddingBottom: 0.0, paddingRight: 0.0, width: 150.0, height: 30.0, enableInsets: true)
//            menuBar.layoutAnchor(top: nil, left: view.leftAnchor, bottom: nil, right: nil, centerX: nil, centerY: appLogo.centerYAnchor, paddingTop: 0.0, paddingLeft: 20.0, paddingBottom: 0.0, paddingRight: 0.0, width: 25.0, height: 25.0, enableInsets: true)
        }
        welcomeView.layoutAnchor(top: appLogo.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, centerX: nil, centerY: nil, paddingTop: 15.0, paddingLeft: 0.0, paddingBottom: 0.0, paddingRight: 0.0, width: 0.0, height: 50.0, enableInsets: true)
        menuBack.layoutAnchor(top: welcomeView.topAnchor, left: welcomeView.leftAnchor, bottom: welcomeView.bottomAnchor, right: nil, centerX: nil, centerY: nil, paddingTop: 0.0, paddingLeft: 0.0, paddingBottom: 0.0, paddingRight: 0.0, width: 50.0, height: 0.0, enableInsets: true)
        titleLabel.layoutAnchor(top: nil, left: menuBack.rightAnchor, bottom: nil, right: nil, centerX: nil, centerY: menuBack.centerYAnchor, paddingTop: 0.0, paddingLeft: 10.0, paddingBottom: 0.0, paddingRight: 0.0, width: 0.0, height: 0.0, enableInsets: true)
        signUpView.layoutAnchor(top: welcomeView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, centerX: nil, centerY: nil, paddingTop: 0.0, paddingLeft: 0.0, paddingBottom: 0.0, paddingRight: 0.0, width: 0.0, height: 60.0, enableInsets: true)
        signUpLabel.layoutAnchor(top: nil, left: nil, bottom: nil, right: nil, centerX: signUpView.centerXAnchor, centerY: signUpView.centerYAnchor, paddingTop: 0.0, paddingLeft: 0.0, paddingBottom: 0.0, paddingRight: 0.0, width: 0.0, height: 0.0, enableInsets: true)
        firstBGView.layoutAnchor(top: signUpView.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, centerX: nil, centerY: nil, paddingTop: 0.0, paddingLeft: 0.0, paddingBottom: 0.0, paddingRight: 0.0, width: 0.0, height: 0.0, enableInsets: true)
        secondBGView.layoutAnchor(top: signUpView.bottomAnchor, left: firstBGView.leftAnchor, bottom: firstBGView.bottomAnchor, right: firstBGView.rightAnchor, centerX: nil, centerY: nil, paddingTop: 0.0, paddingLeft: 0.0, paddingBottom: view.frame.size.height/4.5, paddingRight: 0.0, width: 0.0, height: 0.0, enableInsets: true)
        qrLabel.layoutAnchor(top: secondBGView.topAnchor, left: nil, bottom: nil, right: nil, centerX: secondBGView.centerXAnchor, centerY: nil, paddingTop: 20.0, paddingLeft: 0.0, paddingBottom: 0.0, paddingRight: 0.0, width: 160, height: 25.0, enableInsets: true)
        buttonView.layoutAnchor(top: qrLabel.bottomAnchor, left: nil, bottom: nil, right: nil, centerX: secondBGView.centerXAnchor, centerY: nil, paddingTop: 10.0, paddingLeft: 0.0, paddingBottom: 0.0, paddingRight: 0.0, width: 100.0, height: 100.0, enableInsets: true)
        qrButton.layoutAnchor(top: nil, left: nil, bottom: nil, right: nil, centerX: buttonView.centerXAnchor, centerY: buttonView.centerYAnchor, paddingTop: 0.0, paddingLeft: 0.0, paddingBottom: 0.0, paddingRight: 0.0, width: 80.0, height: 80.0, enableInsets: true)
        inputText.layoutAnchor(top: buttonView.bottomAnchor, left: nil, bottom: nil, right: nil, centerX: secondBGView.centerXAnchor, centerY: nil, paddingTop: 20.0, paddingLeft: 0.0, paddingBottom: 10.0, paddingRight: 0.0, width: view.frame.size.width/2, height: 50.0, enableInsets: true)
        createProfile.layoutAnchor(top: secondBGView.bottomAnchor, left: nil, bottom: nil, right: nil, centerX: firstBGView.centerXAnchor, centerY: nil, paddingTop: 45.0, paddingLeft: 0.0, paddingBottom: 0.0, paddingRight: 0.0, width: view.frame.size.width/1.5, height: 50.0, enableInsets: true)
        signIn.layoutAnchor(top: createProfile.bottomAnchor, left: nil, bottom: nil, right: nil, centerX: firstBGView.centerXAnchor, centerY: nil, paddingTop: 10.0, paddingLeft: 0.0, paddingBottom: 0.0, paddingRight: 0.0, width: 100.0, height: 35.0, enableInsets: true)
    }
}

extension ScanScreenController : UITextFieldDelegate{
    func validateTextFeilds() -> Bool{
        
        if (inputText.text?.count) != 6{
            createProfile.loadingIndicator(show: false)
            createProfile.setTitle("SUBMIT", for: .normal)
            showConfirmAlert(title: "", message: "Invalid Code Count", buttonTitle: "Ok", buttonStyle: .default, confirmAction: nil)
            return false
        }else{
            qrSearch.code = inputText.text!
            return true
        }
    }
    
    func userInformation(_ code: String, _ api_token:String){
        Networking.shared.qrSearch(code, api_token) { (success, error, result, token, username, contact, holderName, picture, comments) in
            
            if success {
                profileInformation.token = token
                qrSearch.userName        = username
                qrSearch.contact         = contact
                qrSearch.holderName      = holderName
                qrSearch.comments        = comments
                let url = URL(string:picture)
                if let data = try? Data(contentsOf: url!)
                {
                    qrSearch.picture = UIImage(data: data)!
                }
                self.createProfile.loadingIndicator(show: false)
                self.createProfile.setTitle("SUBMIT", for: .normal)
                self.showConfirmAlert(title: "", message: "Search Completed", buttonTitle: "Ok", buttonStyle: .default, confirmAction: self.alertAction)
            }
            print("Success")
        }
    }
    
    func alertAction(action: UIAlertAction){
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ScanResultScreenController") as? ScanResultScreenController
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
