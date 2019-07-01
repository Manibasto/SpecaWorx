//
//  SignInScreenController.swift
//  SpecaWorx
//
//  Created by Anil Kumar on 17/05/19.
//  Copyright © 2019 Anil Kumar. All rights reserved.
//

import UIKit

class SignInScreenController: UIViewController {
    
    lazy var appLogo           = customImageClass()
    lazy var welcomeView       = customUIViewClass()
    lazy var signUpView        = customUIViewClass()
    lazy var firstBGView       = customUIViewClass()
    lazy var secondBGView      = customUIViewClass()
    lazy var signInTable       = customTableViewClass()
    
//    private let menuBar        = UIButtonFactory(title: "")
//        .backgroundImage(with: UIImage(named: "mobile-menu")!)
//        .addTarget(self, action: #selector(menuButtonTapped), for: .touchUpInside)
//        .build()
    
    private let menuBack       = UIButtonFactory(title: "")
        .backgroundImage(with: UIImage(named: "back-icon")!)
        .addTarget(self, action: #selector(backButtontapped), for: .touchUpInside)
        .build()
    
    private let titleLabel     = UILabelFactory(text: "LOG IN")
        .numberOf(lines: 0)
        .textAlignment(with: .left)
        .textColor(with: .white)
        .fontSize(of: 18.0)
        .build()
    
    private let signUpLabel    = UILabelFactory(text: "Sign In")
        .numberOf(lines: 0)
        .textAlignment(with: .center)
        .textColor(with: .white)
        .fontSize(of: 15.0)
        .build()
    
    private let signIn         = UIButtonFactory(title: "SIGN IN")
        .backgroundColour(with: UIColor(red: 38/255, green: 87/255, blue: 140/255, alpha: 1.0))
        .textColor(with: .white)
        .textFontSize(with: UIFont(name: "Montserrat-Medium", size: 13.0)!)
        .borderColor(with: UIColor(red: 32/255, green: 76/255, blue: 120/255, alpha: 1.0).cgColor)
        .borderThick(with: 1.0)
        .cornerRadious(with: 25.0)
        .addTarget(self, action: #selector(signInTapped), for: .touchUpInside)
        .build()
    
    private let createProfile  = UIButtonFactory(title: "Create an Account")
        .textColor(with: .white)
        .textFonts(with: UIFont(name: "Montserrat-Medium", size: 12.0)!)
        .addTarget(self, action: #selector(createAccountTapped), for: .touchUpInside)
        .build()
    
    private let forgotPassword = UIButtonFactory(title: "Forgot Password?")
        .textColor(with: .white)
        .textFonts(with: UIFont(name: "Montserrat-Medium", size: 12.0)!)
        .addTarget(self, action: #selector(forgotPasswordTapped), for: .touchUpInside)
        .build()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = true
        appLogo.image                = UIImage(named: "specaworx-logo")
        welcomeView.backgroundColor  = UIColor(red: 40/255, green: 92/255, blue: 148/255, alpha: 1.0)
        signUpView.backgroundColor   = UIColor(red: 50/255, green: 113/255, blue: 180/255, alpha: 1.0)
        firstBGView.backgroundColor  = UIColor(red: 50/255, green: 113/255, blue: 180/255, alpha: 1.0)
        secondBGView.backgroundColor = .white
        
        setUpLayoutViews()
        setUpConstraintsForLayout()
        tableProperties()
        
        if let array = UserDefaults.standard.array(forKey: "mailArray") as? [String] {
            print(array)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }
    
    @objc func menuButtonTapped(){
        slideMenuController()?.toggleLeft()
    }
    
    @objc func backButtontapped(){
        navigationController?.popToRootViewController(animated: true)
    }
    
    @objc func createAccountTapped(){
        if !routingFlag{
            routingFlag = true
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SignUpScreenController") as? SignUpScreenController
            self.navigationController?.pushViewController(vc!, animated: true)
        }else{
            routingFlag = false
            navigationController?.popViewController(animated: true)
        }
    }
    
    @objc func forgotPasswordTapped(){
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ForgotPasswordScreenController") as? ForgotPasswordScreenController
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    @objc func checkBoxtapped(){
        let indexPath = NSIndexPath(item: 2, section: 0)
        guard let cell = signInTable.cellForRow(at: indexPath as IndexPath) as? SignInTableCell else { return }
        if !rememberPasswordFlag.rememberMe {
            rememberPasswordFlag.rememberMe = true
            cell.checkBox.setImage(UIImage(named: "CheckedBox"), for: .normal)
        }else {
            rememberPasswordFlag.rememberMe = false
            cell.checkBox.setImage(UIImage(named: "UncheckedBox"), for: .normal)
        }
    }
    
    @objc func signInTapped(){
        if Reachability.isConnectedToNetwork() {
            signIn.loadingIndicator(show: true)
            signIn.setTitle("", for: .normal)
            validationTextFeilds()
        }else{
            showConfirmAlert(title: "", message: "Sorry, we can't connect right now. Please check your internet connection and try again.", buttonTitle: "Ok", buttonStyle: .default, confirmAction: nil)
        }
    }
    
    func validationTextFeilds(){
        let emailCell = IndexPath(row: 0, section: 0)
        guard let cell1 = signInTable.cellForRow(at: emailCell as IndexPath) as? signUpTableCell else { return }
        
        let passwordCell = IndexPath(row: 1, section: 0)
        guard let cell2 = signInTable.cellForRow(at: passwordCell as IndexPath) as? signUpTableCell else { return }
        
        let emailCount = cell1.textField.text?.count
        let passwordcount = cell2.textField.text?.count
        
        let email = cell1.textField.text
        let password = cell2.textField.text
        
        if emailCount == 0 || passwordcount == 0{
            showConfirmAlert(title: "", message: "Fields Cannot be Empty", buttonTitle: "Ok", buttonStyle: .default, confirmAction: nil)
        }else{
            Networking.shared.signInVerification(email!, password!) { (success, error, result, token, userInfo, user_name, user_contact, holder_name, holder_age , gender, medicines, comments, picture, qrCode) in
                if result == "Successfully logged into your account." {
                    profileInformation.token = token
                    self.signIn.loadingIndicator(show: false)
                    self.signIn.setTitle("SIGN IN", for: .normal)
                    let userInfo = userInfo
                    if userInfo{
                        qrHolderInformation.qrCode           = qrCode
                        qrHolderInformation.qrUsername       = user_name
                        qrHolderInformation.qrHolderContact  = user_contact
                        qrHolderInformation.qrHolderName     = holder_name
                        qrHolderInformation.qrholderAge      = holder_age
                        qrHolderInformation.qrHolderGender   = gender
                        qrHolderInformation.qrHoldermedicine = medicines
                        qrHolderInformation.qrholderComments = comments
                        qrHolderInformation.qrHolderImage    = picture
                        
                        let imageUrl = URL(string: picture)
                        if let data = try? Data(contentsOf: imageUrl!)
                        {
                            UserDefaults.standard.set(data, forKey: "qrHolderImage")
                        }
                        let url = URL(string: qrCode)
                        if let data = try? Data(contentsOf: url!)
                        {
                            UserDefaults.standard.set(data, forKey: "qrCode")
                        }
                        UserDefaults.standard.set(user_name, forKey: "qrUsername")
                        UserDefaults.standard.set(user_contact, forKey: "qrHolderContact")
                        UserDefaults.standard.set(holder_name, forKey: "qrHolderName")
                        UserDefaults.standard.set(holder_age, forKey: "qrholderAge")
                        UserDefaults.standard.set(gender, forKey: "qrHolderGender")
                        UserDefaults.standard.set(medicines, forKey: "qrHoldermedicine")
                        UserDefaults.standard.set(comments, forKey: "qrholderComments")
                        UserDefaults.standard.set(qrCode, forKey: "qrCodeLink")
                        UserDefaults.standard.set(token, forKey: "token")
                        self.profileReady()
                    }else{
                        inCompleteProfile = true
                        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ProfileInformationScreenController") as? ProfileInformationScreenController
                        self.navigationController?.pushViewController(vc!, animated: true)
                    }
//                    if let array = UserDefaults.standard.value(forKey: "mailArray") as? [String]{
//                        if array.contains(email!){
//                            currentLogInMail = email!
//                            UserDefaults.standard.set(currentLogInMail, forKey: "currentLogInMail")
//                            if let data = UserDefaults.standard.value(forKey: currentLogInMail) as? [String : [String : Any]]{
//                                if let profileCompletion = data[currentLogInMail]?["ProfileCompletion"] as? String{
//                                    if profileCompletion == "1"{
//                                        self.profileReady()
//                                    }else{
//                                        inCompleteProfile = true
//                                        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ProfileInformationScreenController") as? ProfileInformationScreenController
//                                        self.navigationController?.pushViewController(vc!, animated: true)
//                                    }
//                                }
//                            }else{
//                                inCompleteProfile = true
//                                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ProfileInformationScreenController") as? ProfileInformationScreenController
//                                self.navigationController?.pushViewController(vc!, animated: true)
//                            }
//                        }
//                    }else{
//                        currentLogInMail = email!
//                        userId(currentLogInMail, forKey: "currentLogInMail")
//                        if let data = UserDefaults.standard.value(forKey: email!) as? [String : [String : Any]]{
//                            print(data)
//                        }
//                        self.showConfirmAlert(title: "", message: "Successfully LoggedIn", buttonTitle: "Ok", buttonStyle: .default, confirmAction: self.alertAction)
//                    }
                }else{
                    self.signIn.loadingIndicator(show: false)
                    self.signIn.setTitle("SIGN IN", for: .normal)
                    self.showConfirmAlert(title: "", message: error, buttonTitle: "Ok", buttonStyle: .default, confirmAction: nil)
                }
            }
        }
    }
    
    func profileReady(){
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let mainViewController = storyBoard.instantiateViewController(withIdentifier: "QRProfileInfoScreenController") as! QRProfileInfoScreenController
        let leftViewController = storyBoard.instantiateViewController(withIdentifier: "SlideMenuScreenController") as! SlideMenuScreenController
        let slideMenuController = ExSlideMenuController(mainViewController: mainViewController, leftMenuViewController: leftViewController)
        slideMenuController.automaticallyAdjustsScrollViewInsets = true
        slideMenuController.delegate = mainViewController as? SlideMenuControllerDelegate
        navigationController?.pushViewController(slideMenuController, animated: true)
    }
    
    func alertAction(action: UIAlertAction){
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let mainViewController = storyBoard.instantiateViewController(withIdentifier: "QRProfileInfoScreenController") as! QRProfileInfoScreenController
        let leftViewController = storyBoard.instantiateViewController(withIdentifier: "SlideMenuScreenController") as! SlideMenuScreenController
        let slideMenuController = ExSlideMenuController(mainViewController: mainViewController, leftMenuViewController: leftViewController)
        slideMenuController.automaticallyAdjustsScrollViewInsets = true
        slideMenuController.delegate = mainViewController as? SlideMenuControllerDelegate
        navigationController?.pushViewController(slideMenuController, animated: true)
    }
    
    func tableProperties(){
        signInTable.register(signUpTableCell.self, forCellReuseIdentifier: "signUpTableCell")
        signInTable.register(SignInTableCell.self, forCellReuseIdentifier: "SignInTableCell")
        signInTable.dataSource = self
        signInTable.delegate = self
        signInTable.tableFooterView = UIView()
        signInTable.separatorStyle = .none
        signInTable.allowsSelection = true
        signInTable.isScrollEnabled = false
    }
}

extension SignInScreenController{
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
        secondBGView.addSubview(signInTable)
        firstBGView.addSubview(createProfile)
        firstBGView.addSubview(forgotPassword)
        firstBGView.addSubview(signIn)
    }
}

extension SignInScreenController{
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
        secondBGView.layoutAnchor(top: signUpView.bottomAnchor, left: firstBGView.leftAnchor, bottom: firstBGView.bottomAnchor, right: firstBGView.rightAnchor, centerX: nil, centerY: nil, paddingTop: 0.0, paddingLeft: 0.0, paddingBottom: view.frame.size.height/4, paddingRight: 0.0, width: 0.0, height: 0.0, enableInsets: true)
        signInTable.layoutAnchor(top: secondBGView.topAnchor, left: secondBGView.leftAnchor, bottom: secondBGView.bottomAnchor, right: secondBGView.rightAnchor, centerX: nil, centerY: nil, paddingTop: 30.0, paddingLeft: 20.0, paddingBottom: 0.0, paddingRight: 20.0, width: 0.0, height: 0.0, enableInsets: true)
        signIn.layoutAnchor(top: secondBGView.bottomAnchor, left: nil, bottom: nil, right: nil, centerX: firstBGView.centerXAnchor, centerY: nil, paddingTop: 40.0, paddingLeft: 0.0, paddingBottom: 0.0, paddingRight: 0.0, width: view.frame.size.width/1.5, height: 50.0, enableInsets: true)
        forgotPassword.layoutAnchor(top: signIn.bottomAnchor, left: nil, bottom: nil, right: nil, centerX: firstBGView.centerXAnchor, centerY: nil, paddingTop: 10.0, paddingLeft: 0.0, paddingBottom: 0.0, paddingRight: 0.0, width: 150.0, height: 30.0, enableInsets: true)
        createProfile.layoutAnchor(top: forgotPassword.bottomAnchor, left: nil, bottom: nil, right: nil, centerX: firstBGView.centerXAnchor, centerY: nil, paddingTop: 5.0, paddingLeft: 0.0, paddingBottom: 0.0, paddingRight: 0.0, width: 150.0, height: 30.0, enableInsets: true)
    }
}

extension SignInScreenController: UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "signUpTableCell", for: indexPath) as? signUpTableCell
            cell?.textField.attributedPlaceholder = NSAttributedString(string: "Enter Email Address", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
            cell?.textField.text = "Arun@destiney.in"
            cell?.selectionStyle = .none
            return cell!
        }else if indexPath.row == 1{
            let cell = tableView.dequeueReusableCell(withIdentifier: "signUpTableCell", for: indexPath) as? signUpTableCell
            cell?.textField.attributedPlaceholder = NSAttributedString(string: "Enter Password", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
            cell?.textField.text = "Qwerty123"
            cell?.selectionStyle = .none
            cell?.textField.isSecureTextEntry = true
            return cell!
        }else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SignInTableCell", for: indexPath) as? SignInTableCell
            cell?.checkBox.addTarget(self, action: #selector(checkBoxtapped), for: .touchUpInside)
            cell?.selectionStyle = .none
            return cell!
        }
    }
}

extension SignInScreenController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 2{
            return 60.0
        }else{
            return 80.0
        }
    }
}
