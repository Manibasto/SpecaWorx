//
//  ViewController.swift
//  SpecaWorx
//
//  Created by Anil Kumar on 17/05/19.
//  Copyright © 2019 Anil Kumar. All rights reserved.
//

import UIKit

class WelcomeScreenController: UIViewController {
    
    lazy var appLogo          = customImageClass()
    lazy var welcomeView      = customUIViewClass()
    lazy var firstBGView      = customUIViewClass()
    lazy var secondBGView     = customUIViewClass()
    lazy var inputText        = TextField()
    lazy var buttonView       = customUIViewClass()
    var groupedStackView      = UIStackView()
    let numberToolbar         = UIToolbar(frame:CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
    
    private let welcomeLabel  = UILabelFactory(text: "Welcome !")
        .numberOf(lines: 0)
        .textAlignment(with: .center)
        .textColor(with: .white)
        .fontSize(of: 18.0)
        .build()
    
    private let qrLabel     = UILabelFactory(text: "Scan QR Code")
        .numberOf(lines: 0)
        .textAlignment(with: .center)
        .textColor(with: .gray)
        .fontSize(of: 16.0)
        .build()
    
    private let qrButton      = UIButtonFactory(title: "")
        .backgroundImage(with: UIImage(named: "QRIcon")!)
        .addTarget(self, action: #selector(qrButtonTapped), for: .touchUpInside)
        .build()
    
    private let enterLabel     = UILabelFactory(text: "ENTER NUMBER CODE")
        .numberOf(lines: 0)
        .textAlignment(with: .center)
        .textColor(with: .gray)
        .fontSize(of: 16.0)
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
    
    private let signInButton      = UIButtonFactory(title: "")
        .addTarget(self, action: #selector(signInTapped), for: .touchUpInside)
        .build()
    
    private let signUpButton      = UIButtonFactory(title: "")
        .addTarget(self, action: #selector(signUpTapped), for: .touchUpInside)
        .build()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor         = .white
        appLogo.image                = UIImage(named: "specaworx-logo")
        welcomeView.backgroundColor  = UIColor(red: 40/255, green: 92/255, blue: 148/255, alpha: 1.0)
        firstBGView.backgroundColor  = UIColor(red: 50/255, green: 113/255, blue: 180/255, alpha: 1.0)
        secondBGView.backgroundColor = .white
        buttonView.backgroundColor   = .lightGray
        inputText.borderStyle        = .line
        inputText.backgroundColor    = .lightGray
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
    
    override func viewWillAppear(_ animated: Bool) {
        routingFlag = false
        navigationController?.navigationBar.isHidden = true
        if userDetail.coder == ""{
            inputText.text = ""
        }else{
            inputText.text = userDetail.coder
        }
    }
    
    override func viewDidLayoutSubviews() {
        let attrs1 = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 14), NSAttributedString.Key.foregroundColor : UIColor.lightGray]
        
        let attrs2 = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 15), NSAttributedString.Key.foregroundColor : UIColor.white]
        
        let attributedString1 = NSMutableAttributedString(string:"Already have an account?", attributes:attrs1)
        
        let attributedString2 = NSMutableAttributedString(string:"Login Here", attributes:attrs2)
        
        attributedString1.append(attributedString2)
        
        signInButton.setAttributedTitle(attributedString1, for: .normal)
        
        let attrs3 = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 14), NSAttributedString.Key.foregroundColor : UIColor.lightGray]
        
        let attrs4 = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 15), NSAttributedString.Key.foregroundColor : UIColor.white]
        
        let attributedString3 = NSMutableAttributedString(string:"Don't have an account?", attributes:attrs3)
        
        let attributedString4 = NSMutableAttributedString(string:"Register Here", attributes:attrs4)
        
        attributedString3.append(attributedString4)
        
        signUpButton.setAttributedTitle(attributedString3, for: .normal)
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
                createProfile.setTitle("SUBMIT", for: .normal)
            }
        }
    }
    
    @objc func signUpTapped(){
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SignUpScreenController") as? SignUpScreenController
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    @objc func signInTapped(){
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SignInScreenController") as? SignInScreenController
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    @objc func qrButtonTapped(){
        welcomeFlag = true
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "QRScannerScreenController") as? QRScannerScreenController
        self.navigationController?.pushViewController(vc!, animated: true)
    }
}

extension WelcomeScreenController{
    func setUpLayoutViews(){
        view.addSubview(appLogo)
        view.addSubview(welcomeView)
        welcomeView.addSubview(welcomeLabel)
        view.addSubview(firstBGView)
        firstBGView.addSubview(secondBGView)
        secondBGView.addSubview(qrLabel)
        secondBGView.addSubview(buttonView)
        buttonView.addSubview(qrButton)
        buttonView.bringSubviewToFront(qrButton)
        secondBGView.addSubview(enterLabel)
        secondBGView.addSubview(inputText)
        secondBGView.addSubview(createProfile)
        firstBGView.addSubview(signInButton)
        firstBGView.addSubview(signUpButton)
    }
}

extension WelcomeScreenController{
    func setUpConstraintsForLayout(){
        switch UIDevice().type {
        case .iPhoneX,.iPhoneXS,.iPhoneXSmax,.iPhoneXR:
            appLogo.layoutAnchor(top: view.topAnchor, left: nil, bottom: nil, right: nil, centerX: view.centerXAnchor, centerY: nil, paddingTop: 65.0, paddingLeft: 0.0, paddingBottom: 0.0, paddingRight: 0.0, width: 150.0, height: 30.0, enableInsets: true)
        default:
            appLogo.layoutAnchor(top: view.topAnchor, left: nil, bottom: nil, right: nil, centerX: view.centerXAnchor, centerY: nil, paddingTop: 40.0, paddingLeft: 0.0, paddingBottom: 0.0, paddingRight: 0.0, width: 150.0, height: 30.0, enableInsets: true)
        }
        welcomeView.layoutAnchor(top: appLogo.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, centerX: nil, centerY: nil, paddingTop: 15.0, paddingLeft: 0.0, paddingBottom: 0.0, paddingRight: 0.0, width: 0.0, height: 50.0, enableInsets: true)
        welcomeLabel.layoutAnchor(top: nil, left: nil, bottom: nil, right: nil, centerX: welcomeView.centerXAnchor, centerY: welcomeView.centerYAnchor, paddingTop: 0.0, paddingLeft: 0.0, paddingBottom: 0.0, paddingRight: 0.0, width: 0.0, height: 0.0, enableInsets: true)
        firstBGView.layoutAnchor(top: welcomeView.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, centerX: nil, centerY: nil, paddingTop: 0.0, paddingLeft: 0.0, paddingBottom: 0.0, paddingRight: 0.0, width: 0.0, height: 0.0, enableInsets: true)
        secondBGView.layoutAnchor(top: firstBGView.topAnchor, left: firstBGView.leftAnchor, bottom: firstBGView.bottomAnchor, right: firstBGView.rightAnchor, centerX: nil, centerY: nil, paddingTop: 15.0, paddingLeft: 15.0, paddingBottom: view.frame.size.height/4.5, paddingRight: 15.0, width: 0.0, height: 0.0, enableInsets: true)
        qrLabel.layoutAnchor(top: secondBGView.topAnchor, left: nil, bottom: nil, right: nil, centerX: secondBGView.centerXAnchor, centerY: nil, paddingTop: 25.0, paddingLeft: 0.0, paddingBottom: 0.0, paddingRight: 0.0, width: 160, height: 25.0, enableInsets: true)
        buttonView.layoutAnchor(top: qrLabel.bottomAnchor, left: nil, bottom: nil, right: nil, centerX: secondBGView.centerXAnchor, centerY: nil, paddingTop: 10.0, paddingLeft: 0.0, paddingBottom: 0.0, paddingRight: 0.0, width: 100.0, height: 100.0, enableInsets: true)
        qrButton.layoutAnchor(top: nil, left: nil, bottom: nil, right: nil, centerX: buttonView.centerXAnchor, centerY: buttonView.centerYAnchor, paddingTop: 0.0, paddingLeft: 0.0, paddingBottom: 0.0, paddingRight: 0.0, width: 80.0, height: 80.0, enableInsets: true)
        enterLabel.layoutAnchor(top: buttonView.bottomAnchor, left: nil, bottom: nil, right: nil, centerX: secondBGView.centerXAnchor, centerY: nil, paddingTop: 10.0, paddingLeft: 0.0, paddingBottom: 0.0, paddingRight: 0.0, width: 0.0, height: 50.0, enableInsets: true)
        inputText.layoutAnchor(top: enterLabel.bottomAnchor, left: nil, bottom: nil, right: nil, centerX: secondBGView.centerXAnchor, centerY: nil, paddingTop: 20.0, paddingLeft: 0.0, paddingBottom: 10.0, paddingRight: 0.0, width: view.frame.size.width/2, height: 40.0, enableInsets: true)
        createProfile.layoutAnchor(top: nil, left: nil, bottom: secondBGView.bottomAnchor, right: nil, centerX: secondBGView.centerXAnchor, centerY: nil, paddingTop: 0.0, paddingLeft: 0.0, paddingBottom: 10.0, paddingRight: 0.0, width: view.frame.size.width/1.5, height: 50, enableInsets: true)
        signInButton.layoutAnchor(top: secondBGView.bottomAnchor, left: nil, bottom: nil, right: nil, centerX: firstBGView.centerXAnchor, centerY: nil, paddingTop: 10.0, paddingLeft: 0.0, paddingBottom: 0.0, paddingRight: 0.0, width: 0.0, height: 50.0, enableInsets: true)
        signUpButton.layoutAnchor(top: signInButton.bottomAnchor, left: nil, bottom: nil, right: nil, centerX: firstBGView.centerXAnchor, centerY: nil, paddingTop: 0.0, paddingLeft: 0.0, paddingBottom: 0.0, paddingRight: 0.0, width: 0.0, height: 50.0, enableInsets: true)
    }
}

extension WelcomeScreenController: UITextFieldDelegate{
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
                userDetail.coder = ""
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
    
    @objc func didTabDoneBarButton(){
        inputText.resignFirstResponder()
    }
}
