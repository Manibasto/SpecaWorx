//
//  ScanResultScreenController.swift
//  SpecaWorx
//
//  Created by Anil Kumar on 21/05/19.
//  Copyright © 2019 Anil Kumar. All rights reserved.
//

import UIKit

class ScanResultScreenController: UIViewController {

    lazy var appLogo          = customImageClass()
    lazy var welcomeView      = customUIViewClass()
    lazy var signUpView       = customUIViewClass()
    lazy var firstBGView      = customUIViewClass()
    lazy var secondBGView     = customUIViewClass()
    lazy var profileTable     = customTableViewClass()
    
//    private let menuBar       = UIButtonFactory(title: "")
//        .backgroundImage(with: UIImage(named: "mobile-menu")!)
//        .build()
    
    private let menuBack      = UIButtonFactory(title: "")
        .backgroundImage(with: UIImage(named: "back-icon")!)
        .addTarget(self, action: #selector(menuBackTapped), for: .touchUpInside)
        .build()
    
    private let titleLabel    = UILabelFactory(text: "SCAN RESULT")
        .numberOf(lines: 0)
        .textAlignment(with: .left)
        .textColor(with: .white)
        .fontSize(of: 18.0)
        .build()
    
    private let signUpLabel   = UILabelFactory(text: "Profile Information")
        .numberOf(lines: 0)
        .textAlignment(with: .center)
        .textColor(with: .white)
        .fontSize(of: 15.0)
        .build()
    
    private let createProfile = UIButtonFactory(title: "MAKE CALL NOW")
        .backgroundColour(with: UIColor(red: 38/255, green: 87/255, blue: 140/255, alpha: 1.0))
        .textColor(with: .white)
        .textFontSize(with: UIFont(name: "Montserrat-Medium", size: 13.0)!)
        .borderColor(with: UIColor(red: 32/255, green: 76/255, blue: 120/255, alpha: 1.0).cgColor)
        .borderThick(with: 1.0)
        .cornerRadious(with: 25.0)
//        .addTarget(self, action: #selector(submitButtonTapped), for: .touchUpInside)
        .build()
    
    private let signIn        = UIButtonFactory(title: "Back")
        .textColor(with: .white)
        .textFonts(with: UIFont(name: "Montserrat-Medium", size: 12.0)!)
        .addTarget(self, action: #selector(backbuttonTapped), for: .touchUpInside)
        .build()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.isNavigationBarHidden = true
        appLogo.image                = UIImage(named: "specaworx-logo")
        welcomeView.backgroundColor  = UIColor(red: 40/255, green: 92/255, blue: 148/255, alpha: 1.0)
        signUpView.backgroundColor   = UIColor(red: 50/255, green: 113/255, blue: 180/255, alpha: 1.0)
        firstBGView.backgroundColor  = UIColor(red: 50/255, green: 113/255, blue: 180/255, alpha: 1.0)
        secondBGView.backgroundColor = UIColor(red: 250/255, green: 250/255, blue: 250/255, alpha: 0.8)
        
        setUpLayoutViews()
        setUpConstraintsForLayout()
        tableProperties()
    }
    
    @objc func backbuttonTapped(){
        navigationController?.popViewController(animated: true)
    }
    
    @objc func menuBackTapped(){
        navigationController?.popViewController(animated: true)
    }
    
    func tableProperties(){
        profileTable.register(ScanResultTableCell1.self, forCellReuseIdentifier: "ScanResultTableCell1")
        profileTable.register(ScanResultTableCell2.self, forCellReuseIdentifier: "ScanResultTableCell2")
        profileTable.dataSource = self
        profileTable.delegate = self
        profileTable.tableFooterView = UIView()
        profileTable.separatorStyle = .none
        profileTable.allowsSelection = true
        profileTable.isScrollEnabled = false
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
        secondBGView.addSubview(profileTable)
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
        secondBGView.layoutAnchor(top: signUpView.bottomAnchor, left: firstBGView.leftAnchor, bottom: firstBGView.bottomAnchor, right: firstBGView.rightAnchor, centerX: nil, centerY: nil, paddingTop: 0.0, paddingLeft: 0.0, paddingBottom: view.frame.size.height/5, paddingRight: 0.0, width: 0.0, height: 0.0, enableInsets: true)
        profileTable.layoutAnchor(top: secondBGView.topAnchor, left: secondBGView.leftAnchor, bottom: secondBGView.bottomAnchor, right: secondBGView.rightAnchor, centerX: nil, centerY: nil, paddingTop: 0.0, paddingLeft: 0.0, paddingBottom: 0.0, paddingRight: 0.0, width: 0.0, height: 0.0, enableInsets: true)
        createProfile.layoutAnchor(top: secondBGView.bottomAnchor, left: nil, bottom: nil, right: nil, centerX: firstBGView.centerXAnchor, centerY: nil, paddingTop: 45.0, paddingLeft: 0.0, paddingBottom: 0.0, paddingRight: 0.0, width: view.frame.size.width/1.5, height: 50.0, enableInsets: true)
        signIn.layoutAnchor(top: createProfile.bottomAnchor, left: nil, bottom: nil, right: nil, centerX: firstBGView.centerXAnchor, centerY: nil, paddingTop: 10.0, paddingLeft: 0.0, paddingBottom: 0.0, paddingRight: 0.0, width: 100.0, height: 35.0, enableInsets: true)
    }
}

extension ScanResultScreenController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0{
            return 170
        }else if indexPath.row == 3{
            return 100
        }else{
            return 60
        }
    }
}

extension ScanResultScreenController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "ScanResultTableCell1", for: indexPath) as! ScanResultTableCell1
            if qrSearchFlag{
                cell.profilePic.image     = userDetail.picture
                cell.holderNameLabel.text = userDetail.holder_name
            }else{
                cell.profilePic.image     = qrSearch.picture
                cell.holderNameLabel.text = qrSearch.holderName
            }
            cell.selectionStyle = .none
            return cell
        }else if indexPath.row == 1{
            let cell = tableView.dequeueReusableCell(withIdentifier: "ScanResultTableCell2", for: indexPath) as! ScanResultTableCell2
            
            if qrSearchFlag{
                cell.NameLabel.text = userDetail.name
            }else{
                cell.NameLabel.text = qrSearch.userName
            }
            
            cell.roleLabel.text = "[Guardian]"
            cell.selectionStyle = .none
            return cell
        }else if indexPath.row == 2{
            let cell = tableView.dequeueReusableCell(withIdentifier: "ScanResultTableCell2", for: indexPath) as! ScanResultTableCell2
            
            if qrSearchFlag{
                cell.NameLabel.text = userDetail.contact
            }else{
                cell.NameLabel.text = qrSearch.contact
            }
            cell.roleLabel.text = "[Contact]"
            cell.selectionStyle = .none
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "ScanResultTableCell2", for: indexPath) as! ScanResultTableCell2
            
            if qrSearchFlag{
                cell.NameLabel.text = "No Data"
            }else{
                cell.NameLabel.text = qrSearch.comments
            }
            cell.roleLabel.text = "[Additional Information]"
            cell.selectionStyle = .none
            return cell
        }
    }
    
    
}
