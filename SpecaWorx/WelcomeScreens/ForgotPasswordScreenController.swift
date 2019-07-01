//
//  ForgotPasswordScreenController.swift
//  SpecaWorx
//
//  Created by Anil Kumar on 17/05/19.
//  Copyright © 2019 Anil Kumar. All rights reserved.
//

import UIKit

class ForgotPasswordScreenController: UIViewController {
    
    lazy var appLogo            = customImageClass()
    lazy var welcomeView        = customUIViewClass()
    lazy var signUpView         = customUIViewClass()
    lazy var firstBGView        = customUIViewClass()
    lazy var secondBGView       = customUIViewClass()
    lazy var passwordResetTable = customTableViewClass()
    
    private let menuBack        = UIButtonFactory(title: "")
        .backgroundImage(with: UIImage(named: "back-icon")!)
        .addTarget(self, action: #selector(backButtontapped), for: .touchUpInside)
        .build()
    
    private let titleLabel      = UILabelFactory(text: "FORGOT PASSWORD")
        .numberOf(lines: 0)
        .textAlignment(with: .left)
        .textColor(with: .white)
        .fontSize(of: 18.0)
        .build()
    
    private let signUpLabel     = UILabelFactory(text: "Password Reset")
        .numberOf(lines: 0)
        .textAlignment(with: .center)
        .textColor(with: .white)
        .fontSize(of: 15.0)
        .build()
    
    private let createProfile   = UIButtonFactory(title: "Submit")
        .backgroundColour(with: UIColor(red: 38/255, green: 87/255, blue: 140/255, alpha: 1.0))
        .textColor(with: .white)
        .textFontSize(with: UIFont(name: "Montserrat-Medium", size: 13.0)!)
        .borderColor(with: UIColor(red: 32/255, green: 76/255, blue: 120/255, alpha: 1.0).cgColor)
        .borderThick(with: 1.0)
        .cornerRadious(with: 25.0)
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
    
    @objc func backButtontapped(){
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func menuButtonTapped(){
        slideMenuController()?.toggleLeft()
    }
    
    func tableProperties(){
        passwordResetTable.register(signUpTableCell.self, forCellReuseIdentifier: "cell")
        passwordResetTable.dataSource = self
        passwordResetTable.delegate = self
        passwordResetTable.tableFooterView = UIView()
        passwordResetTable.separatorStyle = .none
        passwordResetTable.allowsSelection = true
        passwordResetTable.isScrollEnabled = false
    }
}

extension ForgotPasswordScreenController{
    func setUpLayoutViews(){
        view.addSubview(appLogo)
        view.addSubview(welcomeView)
        view.addSubview(signUpView)
        signUpView.addSubview(signUpLabel)
        welcomeView.addSubview(menuBack)
        welcomeView.addSubview(titleLabel)
        view.addSubview(firstBGView)
        firstBGView.addSubview(secondBGView)
        secondBGView.addSubview(passwordResetTable)
        firstBGView.addSubview(createProfile)
        
    }
}

extension ForgotPasswordScreenController{
    func setUpConstraintsForLayout(){
        switch UIDevice().type {
        case .iPhoneX,.iPhoneXS,.iPhoneXSmax,.iPhoneXR:
            appLogo.layoutAnchor(top: view.topAnchor, left: nil, bottom: nil, right: nil, centerX: view.centerXAnchor, centerY: nil, paddingTop: 65.0, paddingLeft: 0.0, paddingBottom: 0.0, paddingRight: 0.0, width: 150.0, height: 30.0, enableInsets: true)
        default:
            appLogo.layoutAnchor(top: view.topAnchor, left: nil, bottom: nil, right: nil, centerX: view.centerXAnchor, centerY: nil, paddingTop: 40.0, paddingLeft: 0.0, paddingBottom: 0.0, paddingRight: 0.0, width: 150.0, height: 30.0, enableInsets: true)
        }
        welcomeView.layoutAnchor(top: appLogo.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, centerX: nil, centerY: nil, paddingTop: 15.0, paddingLeft: 0.0, paddingBottom: 0.0, paddingRight: 0.0, width: 0.0, height: 50.0, enableInsets: true)
        menuBack.layoutAnchor(top: welcomeView.topAnchor, left: welcomeView.leftAnchor, bottom: welcomeView.bottomAnchor, right: nil, centerX: nil, centerY: nil, paddingTop: 0.0, paddingLeft: 0.0, paddingBottom: 0.0, paddingRight: 0.0, width: 50.0, height: 0.0, enableInsets: true)
        titleLabel.layoutAnchor(top: nil, left: menuBack.rightAnchor, bottom: nil, right: nil, centerX: nil, centerY: menuBack.centerYAnchor, paddingTop: 0.0, paddingLeft: 10.0, paddingBottom: 0.0, paddingRight: 0.0, width: 0.0, height: 0.0, enableInsets: true)
        signUpView.layoutAnchor(top: welcomeView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, centerX: nil, centerY: nil, paddingTop: 0.0, paddingLeft: 0.0, paddingBottom: 0.0, paddingRight: 0.0, width: 0.0, height: 60.0, enableInsets: true)
        signUpLabel.layoutAnchor(top: nil, left: nil, bottom: nil, right: nil, centerX: signUpView.centerXAnchor, centerY: signUpView.centerYAnchor, paddingTop: 0.0, paddingLeft: 0.0, paddingBottom: 0.0, paddingRight: 0.0, width: 0.0, height: 0.0, enableInsets: true)
        firstBGView.layoutAnchor(top: signUpView.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, centerX: nil, centerY: nil, paddingTop: 0.0, paddingLeft: 0.0, paddingBottom: 0.0, paddingRight: 0.0, width: 0.0, height: 0.0, enableInsets: true)
        secondBGView.layoutAnchor(top: signUpView.bottomAnchor, left: firstBGView.leftAnchor, bottom: firstBGView.bottomAnchor, right: firstBGView.rightAnchor, centerX: nil, centerY: nil, paddingTop: 0.0, paddingLeft: 0.0, paddingBottom: view.frame.size.height/4.5, paddingRight: 0.0, width: 0.0, height: 0.0, enableInsets: true)
        passwordResetTable.layoutAnchor(top: secondBGView.topAnchor, left: secondBGView.leftAnchor, bottom: secondBGView.bottomAnchor, right: secondBGView.rightAnchor, centerX: nil, centerY: nil, paddingTop: 30.0, paddingLeft: 20.0, paddingBottom: 0.0, paddingRight: 20.0, width: 0.0, height: 0.0, enableInsets: true)
        createProfile.layoutAnchor(top: secondBGView.bottomAnchor, left: nil, bottom: nil, right: nil, centerX: firstBGView.centerXAnchor, centerY: nil, paddingTop: 45.0, paddingLeft: 0.0, paddingBottom: 0.0, paddingRight: 0.0, width: view.frame.size.width/1.5, height: 50.0, enableInsets: true)
    }
}

extension ForgotPasswordScreenController: UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? signUpTableCell
            cell?.textField.attributedPlaceholder = NSAttributedString(string: "Enter New Password", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
            return cell!
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? signUpTableCell
            cell?.textField.attributedPlaceholder = NSAttributedString(string: "Re-Enter Password", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
            cell?.textField.isSecureTextEntry = true
            return cell!
        }
    }
}

extension ForgotPasswordScreenController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
}

