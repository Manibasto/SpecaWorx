//
//  QRProfileInfoScreenController.swift
//  SpecaWorx
//
//  Created by Anil Kumar on 21/05/19.
//  Copyright © 2019 Anil Kumar. All rights reserved.
//

import UIKit
import MessageUI

class QRProfileInfoScreenController: UIViewController {
    
    lazy var appLogo           = customImageClass()
    lazy var welcomeView       = customUIViewClass()
    lazy var signUpView        = customUIViewClass()
    lazy var bottomBarView     = customUIViewClass()
    lazy var qrHoldertable     = customTableViewClass()
    var imageIcon = UIImage()
    var role                   = ["[Guardian]", "[Contact Number]",""]
    var name                   = ["Hello World", "1234567890",""]
    var informationData: [String : [String : Any]] = [:]
    var userName: String       = ""
    var contactNo: String      = ""
    var holderName: String     = ""
    var holderAge: String      = ""
    var holderMedicine: String = ""
    var holderComments: String = ""
    var holderGender: String   = ""
    var holderQRCode: String   = ""
    
    private let menuBar        = UIButtonFactory(title: "")
        .backgroundImage(with: UIImage(named: "mobile-menu")!)
        .addTarget(self, action: #selector(menuButtonTapped), for: .touchUpInside)
        .build()
    
    private let menuBack       = UIButtonFactory(title: "")
        .backgroundImage(with: UIImage(named: "back-icon")!)
        //        .addTarget(self, action: #selector(backButtontapped), for: .touchUpInside)
        .build()
    
    private let titleLabel     = UILabelFactory(text: "QR INFORMATION")
        .numberOf(lines: 0)
        .textAlignment(with: .left)
        .textColor(with: .white)
        .fontSize(of: 18.0)
        .build()
    
    private let qrHolderLabel  = UILabelFactory(text: "QR Code Profile")
        .numberOf(lines: 0)
        .textAlignment(with: .center)
        .textColor(with: .white)
        .fontSize(of: 15.0)
        .build()
    
    private let editButton      = UIButtonFactory(title: "Edit")
        .backgroundColour(with: UIColor(red: 38/255, green: 87/255, blue: 140/255, alpha: 1.0))
        .textColor(with: .white)
        .textFontSize(with: UIFont(name: "Montserrat-Medium", size: 13.0)!)
        .borderColor(with: UIColor(red: 32/255, green: 76/255, blue: 120/255, alpha: 1.0).cgColor)
        .borderThick(with: 1.0)
        .cornerRadious(with: 25.0)
        .addTarget(self, action: #selector(editButtontapped), for: .touchUpInside)
        .build()
    
    private let sendEmail      = UIButtonFactory(title: "SEND EMAIL")
        .backgroundColour(with: UIColor(red: 38/255, green: 87/255, blue: 140/255, alpha: 1.0))
        .textColor(with: .white)
        .textFontSize(with: UIFont(name: "Montserrat-Medium", size: 13.0)!)
        .borderColor(with: UIColor(red: 32/255, green: 76/255, blue: 120/255, alpha: 1.0).cgColor)
        .borderThick(with: 1.0)
        .cornerRadious(with: 25.0)
        .addTarget(self, action: #selector(sendEmailTapped), for: .touchUpInside)
        .build()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UserDefaults.standard.set(true, forKey: "LoggedIn")
        appLogo.image                 = UIImage(named: "specaworx-logo")
        welcomeView.backgroundColor   = UIColor(red: 40/255, green: 92/255, blue: 148/255, alpha: 1.0)
        signUpView.backgroundColor    = UIColor(red: 50/255, green: 113/255, blue: 180/255, alpha: 1.0)
        bottomBarView.backgroundColor = UIColor(red: 50/255, green: 113/255, blue: 180/255, alpha: 1.0)
        
        if let data = UserDefaults.standard.value(forKey: currentLogInMail) as? [String : [String : Any]]{
            informationData = data
        }
        
        if let token = UserDefaults.standard.value(forKey: "token") as? String {
            profileInformation.token = token
        }
        
        setUpLayoutViews()
        setUpConstraintsForLayout()
        tableProperties()
    }
    
    @objc func editButtontapped(){
        editFlag = true
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ProfileInformationScreenController") as? ProfileInformationScreenController
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    @objc func menuButtonTapped(){
        slideMenuController()?.toggleLeft()
    }
}

extension QRProfileInfoScreenController{
    
    func setUpLayoutViews(){
        view.addSubview(appLogo)
        view.addSubview(menuBar)
        view.addSubview(welcomeView)
        view.addSubview(signUpView)
        signUpView.addSubview(qrHolderLabel)
        welcomeView.addSubview(menuBack)
        welcomeView.addSubview(titleLabel)
        view.addSubview(bottomBarView)
        view.addSubview(qrHoldertable)
        bottomBarView.addSubview(sendEmail)
        bottomBarView.addSubview(editButton)
    }
    
    func setUpConstraintsForLayout(){
        switch UIDevice().type {
        case .iPhoneX,.iPhoneXS,.iPhoneXSmax,.iPhoneXR:
            appLogo.layoutAnchor(top: view.topAnchor, left: nil, bottom: nil, right: nil, centerX: view.centerXAnchor, centerY: nil, paddingTop: 65.0, paddingLeft: 0.0, paddingBottom: 0.0, paddingRight: 0.0, width: 150.0, height: 30.0, enableInsets: true)
            menuBar.layoutAnchor(top: nil, left: view.leftAnchor, bottom: nil, right: nil, centerX: nil, centerY: appLogo.centerYAnchor, paddingTop: 0.0, paddingLeft: 20.0, paddingBottom: 0.0, paddingRight: 0.0, width: 25.0, height: 25.0, enableInsets: true)
            bottomBarView.layoutAnchor(top: nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, centerX: nil, centerY: nil, paddingTop: 0.0, paddingLeft: 0.0, paddingBottom: 0.0, paddingRight: 0.0, width: 0.0, height: view.frame.size.height/5.5, enableInsets: true)
        default:
            appLogo.layoutAnchor(top: view.topAnchor, left: nil, bottom: nil, right: nil, centerX: view.centerXAnchor, centerY: nil, paddingTop: 40.0, paddingLeft: 0.0, paddingBottom: 0.0, paddingRight: 0.0, width: 150.0, height: 30.0, enableInsets: true)
            menuBar.layoutAnchor(top: nil, left: view.leftAnchor, bottom: nil, right: nil, centerX: nil, centerY: appLogo.centerYAnchor, paddingTop: 0.0, paddingLeft: 20.0, paddingBottom: 0.0, paddingRight: 0.0, width: 25.0, height: 25.0, enableInsets: true)
            bottomBarView.layoutAnchor(top: nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, centerX: nil, centerY: nil, paddingTop: 0.0, paddingLeft: 0.0, paddingBottom: 0.0, paddingRight: 0.0, width: 0.0, height: view.frame.size.height/6, enableInsets: true)
        }
        welcomeView.layoutAnchor(top: appLogo.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, centerX: nil, centerY: nil, paddingTop: 15.0, paddingLeft: 0.0, paddingBottom: 0.0, paddingRight: 0.0, width: 0.0, height: 50.0, enableInsets: true)
        menuBack.layoutAnchor(top: welcomeView.topAnchor, left: welcomeView.leftAnchor, bottom: welcomeView.bottomAnchor, right: nil, centerX: nil, centerY: nil, paddingTop: 0.0, paddingLeft: 0.0, paddingBottom: 0.0, paddingRight: 0.0, width: 50.0, height: 0.0, enableInsets: true)
        titleLabel.layoutAnchor(top: nil, left: menuBack.rightAnchor, bottom: nil, right: nil, centerX: nil, centerY: menuBack.centerYAnchor, paddingTop: 0.0, paddingLeft: 10.0, paddingBottom: 0.0, paddingRight: 0.0, width: 0.0, height: 0.0, enableInsets: true)
        signUpView.layoutAnchor(top: welcomeView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, centerX: nil, centerY: nil, paddingTop: 0.0, paddingLeft: 0.0, paddingBottom: 0.0, paddingRight: 0.0, width: 0.0, height: 60.0, enableInsets: true)
        qrHolderLabel.layoutAnchor(top: nil, left: nil, bottom: nil, right: nil, centerX: signUpView.centerXAnchor, centerY: signUpView.centerYAnchor, paddingTop: 0.0, paddingLeft: 0.0, paddingBottom: 0.0, paddingRight: 0.0, width: 0.0, height: 0.0, enableInsets: true)
        qrHoldertable.layoutAnchor(top: signUpView.bottomAnchor, left: view.leftAnchor, bottom: bottomBarView.topAnchor, right: view.rightAnchor, centerX: nil, centerY: nil, paddingTop: 10.0, paddingLeft: 30.0, paddingBottom: 0.0, paddingRight: 30.0, width: 0.0, height: 0.0, enableInsets: true)
        sendEmail.layoutAnchor(top: bottomBarView.topAnchor, left: nil, bottom: nil, right: bottomBarView.rightAnchor, centerX: nil, centerY: nil, paddingTop: 20.0, paddingLeft: 0.0, paddingBottom: 0.0, paddingRight: 20.0, width: view.frame.size.width/2.5, height: 50.0, enableInsets: true)
        editButton.layoutAnchor(top: bottomBarView.topAnchor, left: bottomBarView.leftAnchor, bottom: nil, right: nil, centerX: nil, centerY: nil, paddingTop: 20.0, paddingLeft: 20.0, paddingBottom: 0.0, paddingRight: 0.0, width: view.frame.size.width/2.5, height: 50.0, enableInsets: true)
    }
    
    func tableProperties(){
        qrHoldertable.register(QRIconTableCell.self, forCellReuseIdentifier: "QRIconTableCell")
        qrHoldertable.register(QRInfoTableCell.self, forCellReuseIdentifier: "QRInfoTableCell")
        qrHoldertable.register(QRInfoTableCell1.self, forCellReuseIdentifier: "QRInfoTableCell1")
        qrHoldertable.register(QRInfoTableCell2.self, forCellReuseIdentifier: "QRInfoTableCell2")
        qrHoldertable.dataSource = self
        qrHoldertable.delegate = self
        qrHoldertable.tableFooterView = UIView()
        qrHoldertable.separatorStyle = .singleLine
        qrHoldertable.allowsSelection = true
        qrHoldertable.isScrollEnabled = false
    }
}

extension QRProfileInfoScreenController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0{
            return 110
        }else if indexPath.row == 3{
            return 150
        }else {
            return 70
        }
    }
}

extension QRProfileInfoScreenController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "QRIconTableCell", for: indexPath) as? QRIconTableCell
            if let data = UserDefaults.standard.value(forKey: "qrCode") as? Data{
                cell?.qrIcon.image = UIImage(data: data)
            }
            cell?.selectionStyle = .none
            return cell!
        }else if indexPath.row == 1{
            let cell = tableView.dequeueReusableCell(withIdentifier: "QRInfoTableCell", for: indexPath) as? QRInfoTableCell
            cell?.roleLabel.text = "[Guardian]"
            if let name = UserDefaults.standard.value(forKey: "qrUsername") as? String{
                userName = name
                cell?.infoLabel.text = name
            }
            cell?.selectionStyle = .none
            return cell!
        }else if indexPath.row == 2{
            let cell = tableView.dequeueReusableCell(withIdentifier: "QRInfoTableCell1", for: indexPath) as? QRInfoTableCell1
            if let contact = UserDefaults.standard.value(forKey: "qrHolderContact") as? String{
                contactNo = contact
                cell?.contactLabel.text = contact
            }
            cell?.roleLabel.text    = "[Contact Number]"
            cell?.selectionStyle = .none
            return cell!
        }else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "QRInfoTableCell2", for: indexPath) as? QRInfoTableCell2
            if let imageData = UserDefaults.standard.value(forKey: "qrHolderImage") as? Data{
                let image: UIImage = UIImage(data: imageData)!
                cell?.profilePic.image    = image
            }
            if let HolderName = UserDefaults.standard.value(forKey: "qrHolderName") as? String{
                cell?.holderName.text = HolderName.uppercased()
                holderName = HolderName
            }
            if let HolderAge = UserDefaults.standard.value(forKey: "qrholderAge") as? String{
                cell?.holderAge.text = HolderAge
                holderAge = HolderAge
            }
            if let HolderGender = UserDefaults.standard.value(forKey: "qrHolderGender") as? String{
                cell?.holderGender.text = HolderGender
                holderGender = HolderGender
            }
            if let HolderMedicine = UserDefaults.standard.value(forKey: "qrHoldermedicine") as? String{
                cell?.holderMedicine.text = HolderMedicine
                holderMedicine = HolderMedicine
            }
            if let HolderComments = UserDefaults.standard.value(forKey: "qrholderComments") as? String{
                cell?.holderComments.text = HolderComments
                holderComments = HolderComments
            }
            if let QrCode = UserDefaults.standard.value(forKey: "qrCodeLink") as? String{
                holderQRCode = QrCode
            }
            cell?.selectionStyle = .none
            return cell!
        }
    }
}

extension QRProfileInfoScreenController: MFMailComposeViewControllerDelegate{
    
    @objc func sendEmailTapped() {
        let mailComposeViewController = configureMailComposer()
        if MFMailComposeViewController.canSendMail(){
            self.present(mailComposeViewController, animated: true, completion: nil)
        }else{
            print("Can't send email")
        }
    }
    
    func configureMailComposer() -> MFMailComposeViewController{
        let mailComposeVC = MFMailComposeViewController()
        mailComposeVC.mailComposeDelegate = self
        mailComposeVC.setToRecipients([])
        mailComposeVC.setSubject("QR Information")
        mailComposeVC.setMessageBody("QRCode:\(holderQRCode)\nUserName:\(userName.uppercased())\nContactNo:\(contactNo)\nHolderName:\(holderName.uppercased())\nHolderAge:\(holderAge)\nHolderGender:\(holderGender.uppercased())\nHolderMedicine:\(holderMedicine)\nHolderComments:\(holderComments)", isHTML: false)
        return mailComposeVC
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        print(result.rawValue)
        self.dismiss(animated: true, completion: nil)
    }
}
