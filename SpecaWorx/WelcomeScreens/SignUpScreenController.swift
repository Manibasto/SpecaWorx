//
//  SignUpScreenController.swift
//  SpecaWorx
//
//  Created by Anil Kumar on 17/05/19.
//  Copyright © 2019 Anil Kumar. All rights reserved.
//

import UIKit

class SignUpScreenController: UIViewController {
    
    lazy var appLogo          = customImageClass()
    lazy var welcomeView      = customUIViewClass()
    lazy var signUpView       = customUIViewClass()
    lazy var firstBGView      = customUIViewClass()
    lazy var secondBGView     = customUIViewClass()
    lazy var signUpTable      = customTableViewClass()
    var mailArray:[String]    = []
    
//    private let menuBar       = UIButtonFactory(title: "")
//        .backgroundImage(with: UIImage(named: "mobile-menu")!)
//        .addTarget(self, action: #selector(menuButtonTapped), for: .touchUpInside)
//        .build()
    
    private let menuBack      = UIButtonFactory(title: "")
        .backgroundImage(with: UIImage(named: "back-icon")!)
        .addTarget(self, action: #selector(backButtontapped), for: .touchUpInside)
        .build()
    
    private let titleLabel    = UILabelFactory(text: "CREATE AN ACCOUNT")
        .numberOf(lines: 0)
        .textAlignment(with: .left)
        .textColor(with: .white)
        .fontSize(of: 18.0)
        .build()
    
    private let signUpLabel   = UILabelFactory(text: "Sign Up")
        .numberOf(lines: 0)
        .textAlignment(with: .center)
        .textColor(with: .white)
        .fontSize(of: 15.0)
        .build()
    
    private let createProfile = UIButtonFactory(title: "CREATE PROFILE")
        .backgroundColour(with: UIColor(red: 38/255, green: 87/255, blue: 140/255, alpha: 1.0))
        .textColor(with: .white)
        .textFontSize(with: UIFont(name: "Montserrat-Medium", size: 13.0)!)
        .borderColor(with: UIColor(red: 32/255, green: 76/255, blue: 120/255, alpha: 1.0).cgColor)
        .borderThick(with: 1.0)
        .cornerRadious(with: 25.0)
        .addTarget(self, action: #selector(signUpButtontapped), for: .touchUpInside)
        .build()
    
    private let signIn        = UIButtonFactory(title: "Sign In")
        .textColor(with: .white)
        .textFonts(with: UIFont(name: "Montserrat-Medium", size: 12.0)!)
        .addTarget(self, action: #selector(signInButtonTapped), for: .touchUpInside)
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
    
    @objc func signUpButtontapped(){
        if Reachability.isConnectedToNetwork() {
            createProfile.loadingIndicator(show: true)
            createProfile.setTitle("", for: .normal)
            validationTextFeilds()
        }else{
            showConfirmAlert(title: "", message: "Sorry, we can't connect right now. Please check your internet connection and try again.", buttonTitle: "Ok", buttonStyle: .default, confirmAction: nil)
        }
    }
    
    func validationTextFeilds(){
        let emailCell = IndexPath(row: 0, section: 0)
        guard let cell1 = signUpTable.cellForRow(at: emailCell as IndexPath) as? signUpTableCell else { return }
        
        let passwordCell = IndexPath(row: 1, section: 0)
        guard let cell2 = signUpTable.cellForRow(at: passwordCell as IndexPath) as? signUpTableCell else { return }
        
        let confirmPasswordCell = IndexPath(row: 2, section: 0)
        guard let cell3 = signUpTable.cellForRow(at: confirmPasswordCell as IndexPath) as? signUpTableCell else { return }
        
        let password = cell2.textField.text
        let confirmPassword = cell3.textField.text
        
        if password != confirmPassword{
            self.createProfile.loadingIndicator(show: false)
            self.createProfile.setTitle("CREATE PROFILE", for: .normal)
            showConfirmAlert(title: "", message: "Passwords do not match", buttonTitle: "Ok", buttonStyle: .default, confirmAction: nil)
        }else{
            let email = cell1.textField.text
            let password = cell2.textField.text
            let response = Validation.shared.validate(values: (ValidationType.email, email!),(ValidationType.password, password!))
            switch response{
            case .success:
                if let emailArray = UserDefaults.standard.array(forKey: "mailArray") as? [String] {
                    mailArray = emailArray
                    mailArray.append(email!)
                    UserDefaults.standard.set(mailArray, forKey: "mailArray")
                } else {
                    mailArray = [String]()
                    mailArray.append(email!)
                    UserDefaults.standard.set(mailArray, forKey: "mailArray")
                }
                currentLogInMail = email!
                verifyDetails(email: email!, password: password!, confirmPassword: confirmPassword!)
            case .failure(_, let error):
                self.createProfile.loadingIndicator(show: false)
                self.createProfile.setTitle("CREATE PROFILE", for: .normal)
                showConfirmAlert(title: "", message: error.rawValue, buttonTitle: "Ok", buttonStyle: .default, confirmAction: nil)
            }
        }
    }
    
    func verifyDetails(email: String, password: String, confirmPassword : String){
        Networking.shared.signUpVerification(email, password, confirmPassword) { (success, error, result, token) in
            if result == "User created successfully"{
                profileInformation.token = token
                UserDefaults.standard.set(token, forKey: "token")
                self.createProfile.loadingIndicator(show: false)
                self.createProfile.setTitle("CREATE PROFILE", for: .normal)
                self.showConfirmAlert(title: "", message: "Account Created Successfully", buttonTitle: "Ok", buttonStyle: .default, confirmAction: self.alertAction)
            }else{
                self.createProfile.loadingIndicator(show: false)
                self.createProfile.setTitle("CREATE PROFILE", for: .normal)
                self.showConfirmAlert(title: "", message: error, buttonTitle: "Ok", buttonStyle: .default, confirmAction: nil)
            }
        }
    }
    
    func alertAction(action: UIAlertAction){
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ProfileInformationScreenController") as? ProfileInformationScreenController
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    @objc func signInButtonTapped(){
        if routingFlag{
            routingFlag = false
            navigationController?.popViewController(animated: true)
        }else{
            routingFlag = true
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SignInScreenController") as? SignInScreenController
            self.navigationController?.pushViewController(vc!, animated: true)
        }
    }
    
    func tableProperties(){
        signUpTable.register(signUpTableCell.self, forCellReuseIdentifier: "signUpTableCell")
        signUpTable.dataSource = self
        signUpTable.delegate = self
        signUpTable.tableFooterView = UIView()
        signUpTable.separatorStyle = .none
        signUpTable.allowsSelection = true
        signUpTable.isScrollEnabled = false
    }
}

extension SignUpScreenController{
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
        secondBGView.addSubview(signUpTable)
        firstBGView.addSubview(createProfile)
        firstBGView.addSubview(signIn)
        
    }
}

extension SignUpScreenController{
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
        signUpTable.layoutAnchor(top: secondBGView.topAnchor, left: secondBGView.leftAnchor, bottom: secondBGView.bottomAnchor, right: secondBGView.rightAnchor, centerX: nil, centerY: nil, paddingTop: 30.0, paddingLeft: 20.0, paddingBottom: 0.0, paddingRight: 20.0, width: 0.0, height: 0.0, enableInsets: true)
        createProfile.layoutAnchor(top: secondBGView.bottomAnchor, left: nil, bottom: nil, right: nil, centerX: firstBGView.centerXAnchor, centerY: nil, paddingTop: 45.0, paddingLeft: 0.0, paddingBottom: 0.0, paddingRight: 0.0, width: view.frame.size.width/1.5, height: 50.0, enableInsets: true)
        signIn.layoutAnchor(top: createProfile.bottomAnchor, left: nil, bottom: nil, right: nil, centerX: firstBGView.centerXAnchor, centerY: nil, paddingTop: 10.0, paddingLeft: 0.0, paddingBottom: 0.0, paddingRight: 0.0, width: 100.0, height: 35.0, enableInsets: true)
    }
}

extension SignUpScreenController: UITableViewDataSource{
    
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
            cell?.selectionStyle = .none
            return cell!
        }else if indexPath.row == 1{
            let cell = tableView.dequeueReusableCell(withIdentifier: "signUpTableCell", for: indexPath) as? signUpTableCell
            cell?.textField.attributedPlaceholder = NSAttributedString(string: "Enter Password", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
            cell?.textField.isSecureTextEntry = true
            cell?.selectionStyle = .none
            return cell!
        }else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "signUpTableCell", for: indexPath) as? signUpTableCell
            cell?.textField.attributedPlaceholder = NSAttributedString(string: "Confirm Password", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
            cell?.textField.isSecureTextEntry = true
            cell?.selectionStyle = .none
            return cell!
        }
    }
}

extension SignUpScreenController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
}
