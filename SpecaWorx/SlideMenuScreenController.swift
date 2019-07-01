//
//  SlideMenuScreenController.swift
//  SpecaWorx
//
//  Created by Anil Kumar on 17/05/19.
//  Copyright © 2019 Anil Kumar. All rights reserved.
//

import UIKit

class SlideMenuScreenController: UIViewController {

    lazy var slideMenuTable       = customTableViewClass()
    private let menuBar           = UIButtonFactory(title: "")
        .backgroundImage(with: UIImage(named: "mobile-menu")!)
        .addTarget(self, action: #selector(menuButtonTapped), for: .touchUpInside)
        .build()
    
    let titleLabel  = ["ABOUT", "SCAN", "BUY","LOG OUT"]
    let icon        = ["About", "Scan", "Buy","Logout"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 8/255, green: 30/255, blue: 49/255, alpha: 1.0)
        setUpLayoutViews()
        setUpConstraintsForLayout()
        tableProperties()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }
    
    func setUpLayoutViews(){
        view.addSubview(menuBar)
        view.addSubview(slideMenuTable)
    }
    
    @objc func menuButtonTapped(){
        slideMenuController()?.closeLeft()
    }
    
    func setUpConstraintsForLayout(){
        switch UIDevice().type {
        case .iPhoneX,.iPhoneXS,.iPhoneXSmax,.iPhoneXR:
            menuBar.layoutAnchor(top: view.topAnchor, left: nil, bottom: nil, right: view.rightAnchor, centerX: nil, centerY: nil, paddingTop: 50.0, paddingLeft: 0.0, paddingBottom: 0.0, paddingRight: 20.0, width: 25.0, height: 25.0, enableInsets: true)
        default:
            menuBar.layoutAnchor(top: view.topAnchor, left: nil, bottom: nil, right: view.rightAnchor, centerX: nil, centerY: nil, paddingTop: 30.0, paddingLeft: 0.0, paddingBottom: 0.0, paddingRight: 20.0, width: 25.0, height: 25.0, enableInsets: true)
        }
        slideMenuTable.layoutAnchor(top: menuBar.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, centerX: nil, centerY: nil, paddingTop: 40.0, paddingLeft: 20.0, paddingBottom: 0.0, paddingRight: 30.0, width: 0.0, height: 0.0, enableInsets: true)
    }
    
    func tableProperties(){
        slideMenuTable.register(SlideMenuTableCell.self, forCellReuseIdentifier: "SlideMenuTableCell")
        slideMenuTable.backgroundColor = UIColor(red: 8/255, green: 30/255, blue: 49/255, alpha: 1.0)
        slideMenuTable.dataSource = self
        slideMenuTable.delegate = self
        slideMenuTable.tableFooterView = UIView()
        slideMenuTable.separatorStyle = .singleLine
        slideMenuTable.allowsSelection = true
        slideMenuTable.isScrollEnabled = false
    }
}

extension SlideMenuScreenController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0{
            return 1
        }else{
            return 60.0
        }
    }
}

extension SlideMenuScreenController: UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "SlideMenuTableCell", for: indexPath) as! SlideMenuTableCell
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "SlideMenuTableCell", for: indexPath) as! SlideMenuTableCell
            cell.icon.image = UIImage(named: icon[indexPath.row-1])
            cell.label.text = titleLabel[indexPath.row-1]
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 1{
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "AboutScreenControllerViewController") as? AboutScreenControllerViewController
            self.navigationController?.pushViewController(vc!, animated: true)
        }else if indexPath.row == 2{
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ScanScreenController") as? ScanScreenController
            self.navigationController?.pushViewController(vc!, animated: true)
        }else if indexPath.row == 4{
            UserDefaults.standard.removeObject(forKey: "LoggedIn")
            UserDefaults.standard.removeObject(forKey: "qrCode")
            UserDefaults.standard.removeObject(forKey: "qrUsername")
            UserDefaults.standard.removeObject(forKey: "qrHolderContact")
            UserDefaults.standard.removeObject(forKey: "qrHolderImage")
            UserDefaults.standard.removeObject(forKey: "qrHolderName")
            UserDefaults.standard.removeObject(forKey: "qrholderAge")
            UserDefaults.standard.removeObject(forKey: "qrHolderGender")
            UserDefaults.standard.removeObject(forKey: "qrHoldermedicine")
            UserDefaults.standard.removeObject(forKey: "qrholderComments")
            UserDefaults.standard.removeObject(forKey: "qrHoldermedicine")
            userDetail.coder = ""
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "WelcomeScreenController") as? WelcomeScreenController
            self.navigationController?.pushViewController(vc!, animated: true)
            
        }
    }
}
