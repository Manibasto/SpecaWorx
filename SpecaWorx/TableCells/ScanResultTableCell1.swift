//
//  ScanResultTableCell1.swift
//  SpecaWorx
//
//  Created by Anil Kumar on 22/05/19.
//  Copyright © 2019 Anil Kumar. All rights reserved.
//

import UIKit

class ScanResultTableCell1: UITableViewCell {

    lazy var customView       = customUIViewClass()
    lazy var profilePic       = customImageClass()
    
    let holderNameLabel       = UILabelFactory(text: "")
        .numberOf(lines: 0)
        .textAlignment(with: .center)
        .textColor(with: UIColor(red: 50/255, green: 113/255, blue: 180/255, alpha: 1.0))
        .fontSize(of: 15.0)
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
        customView.addSubview(holderNameLabel)
        customView.layer.borderColor = UIColor.lightGray.cgColor
        customView.layer.borderWidth = 1.0
        
        setUpConstraintsForLayout()
    }
    
    func setUpConstraintsForLayout(){
        customView.layoutAnchor(top: topAnchor, left: nil, bottom: nil, right: nil, centerX: centerXAnchor, centerY: nil, paddingTop: 10.0, paddingLeft: 0.0, paddingBottom: 0.0, paddingRight: 0.0, width: 150.0, height: 150.0, enableInsets: true)
        
        profilePic.layoutAnchor(top: customView.topAnchor, left: customView.leftAnchor, bottom: customView.bottomAnchor, right: customView.rightAnchor, centerX: nil, centerY: nil, paddingTop: 10.0, paddingLeft: 20.0, paddingBottom: 30.0, paddingRight: 20.0, width: 0.0, height: 0.0, enableInsets: true)
        
        holderNameLabel.layoutAnchor(top: profilePic.bottomAnchor, left: customView.leftAnchor, bottom: customView.bottomAnchor, right: customView.rightAnchor, centerX: nil, centerY: nil, paddingTop: 0.0, paddingLeft: 0.0, paddingBottom: 0.0, paddingRight: 0.0, width: 0.0, height: 0.0, enableInsets: true)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
