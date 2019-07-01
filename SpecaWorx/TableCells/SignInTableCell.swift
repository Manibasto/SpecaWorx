//
//  SignInTableCell.swift
//  SpecaWorx
//
//  Created by Anil Kumar on 17/05/19.
//  Copyright © 2019 Anil Kumar. All rights reserved.
//

import UIKit

class SignInTableCell: UITableViewCell {
    
    let checkBox   = UIButtonFactory(title: "")
        .backgroundImage(with: UIImage(named: "UncheckedBox")!)
        .build()
    
    private let infoLabel  = UILabelFactory(text: "Remember me")
        .numberOf(lines: 0)
        .textAlignment(with: .left)
        .textColor(with: .gray)
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
        addSubview(checkBox)
        addSubview(infoLabel)
        
        bringSubviewToFront(checkBox)
        
        setUpConstraintsForLayout()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpConstraintsForLayout(){
        checkBox.layoutAnchor(top: nil, left: leftAnchor, bottom: nil, right: nil, centerX: nil, centerY: centerYAnchor, paddingTop: 0.0, paddingLeft: 35.0, paddingBottom: 0.0, paddingRight: 0.0, width: 20.0, height: 20.0, enableInsets: true)
        infoLabel.layoutAnchor(top: nil, left: checkBox.rightAnchor, bottom: nil, right: nil, centerX: nil, centerY: checkBox.centerYAnchor, paddingTop: 0.0, paddingLeft: 10.0, paddingBottom: 0.0, paddingRight: 0.0, width: 0.0, height: 0.0, enableInsets: true)
    }
}


