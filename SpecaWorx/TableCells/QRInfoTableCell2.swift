//
//  QRInfoTableCell2.swift
//  SpecaWorx
//
//  Created by Anil Kumar on 21/05/19.
//  Copyright © 2019 Anil Kumar. All rights reserved.
//

import UIKit

class QRInfoTableCell2: UITableViewCell {

    lazy var customView = customUIViewClass()
    lazy var profilePic = customImageClass()
    
    let holderName       = UILabelFactory(text: "")
        .numberOf(lines: 0)
        .textAlignment(with: .left)
        .textColor(with: UIColor(red: 76/255, green: 76/255, blue: 76/255, alpha: 1.0))
        .fontSize(of: 16.0)
        .build()
    
    let holderAge        = UILabelFactory(text: "")
        .numberOf(lines: 0)
        .textAlignment(with: .left)
        .textColor(with: UIColor(red: 72/255, green: 72/255, blue: 72/255, alpha: 1.0))
        .fontSize(of: 15.0)
        .build()
    
    let holderGender     = UILabelFactory(text: "")
        .numberOf(lines: 0)
        .textAlignment(with: .left)
        .textColor(with: UIColor(red: 72/255, green: 72/255, blue: 72/255, alpha: 1.0))
        .fontSize(of: 15.0)
        .build()
    
    let holderMedicine   = UILabelFactory(text: "")
        .numberOf(lines: 0)
        .textAlignment(with: .left)
        .textColor(with: UIColor(red: 72/255, green: 72/255, blue: 72/255, alpha: 1.0))
        .fontSize(of: 15.0)
        .build()
    
    let holderComments   = UILabelFactory(text: "")
        .numberOf(lines: 0)
        .textAlignment(with: .left)
        .textColor(with: UIColor(red: 72/255, green: 72/255, blue: 72/255, alpha: 0.8))
        .fontSize(of: 13.0)
        .build()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(customView)
        customView.addSubview(profilePic)
        customView.addSubview(holderName)
        customView.addSubview(holderAge)
        customView.addSubview(holderGender)
        customView.addSubview(holderMedicine)
        customView.addSubview(holderComments)
        
        setUpConstraintsForLayout()
    }
    
    func setUpConstraintsForLayout(){
        customView.layoutAnchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, centerX: nil, centerY: nil, paddingTop: 5.0, paddingLeft: 5.0, paddingBottom: 5.0, paddingRight: 5.0, width: 0.0, height: 0.0, enableInsets: true)
        
        profilePic.layoutAnchor(top: customView.topAnchor, left: customView.leftAnchor, bottom: nil, right: nil, centerX: nil, centerY: nil, paddingTop: 10.0, paddingLeft: 10.0, paddingBottom: 0.0, paddingRight: 0.0, width: 60.0, height: 60.0, enableInsets: true)
        
        holderName.layoutAnchor(top: customView.topAnchor, left: profilePic.rightAnchor, bottom: nil, right: customView.rightAnchor, centerX: nil, centerY: nil, paddingTop: 10.0, paddingLeft: 5.0, paddingBottom: 0.0, paddingRight: 0.0, width: 0.0, height: 20, enableInsets: true)
        
        holderAge.layoutAnchor(top: holderName.bottomAnchor, left: holderName.leftAnchor, bottom: nil, right: holderName.rightAnchor, centerX: nil, centerY: nil, paddingTop: 5.0, paddingLeft: 0.0, paddingBottom: 0.0, paddingRight: 0.0, width: 0.0, height: 15.0, enableInsets: true)
        
        holderGender.layoutAnchor(top: holderAge.bottomAnchor, left: holderName.leftAnchor, bottom: nil, right: holderName.rightAnchor, centerX: nil, centerY: nil, paddingTop: 5.0, paddingLeft: 0.0, paddingBottom: 0.0, paddingRight: 0.0, width: 0.0, height: 15.0, enableInsets: true)
        
        holderMedicine.layoutAnchor(top: holderGender.bottomAnchor, left: holderName.leftAnchor, bottom: nil, right: holderName.rightAnchor, centerX: nil, centerY: nil, paddingTop: 5.0, paddingLeft: 0.0, paddingBottom: 0.0, paddingRight: 0.0, width: 0.0, height: 15.0, enableInsets: true)
        
        holderComments.layoutAnchor(top: holderMedicine.bottomAnchor, left: holderName.leftAnchor, bottom: customView.bottomAnchor, right: holderName.rightAnchor, centerX: nil, centerY: nil, paddingTop: 5.0, paddingLeft: 0.0, paddingBottom: 0.0, paddingRight: 0.0, width: 0.0, height: 0.0, enableInsets: true)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
