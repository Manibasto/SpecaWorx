//
//  ScanResultTableCell2.swift
//  SpecaWorx
//
//  Created by Anil Kumar on 22/05/19.
//  Copyright © 2019 Anil Kumar. All rights reserved.
//

import UIKit

class ScanResultTableCell2: UITableViewCell {
    
    let NameLabel       = UILabelFactory(text: "")
        .numberOf(lines: 0)
        .textAlignment(with: .center)
        .textColor(with: UIColor(red: 80/255, green: 80/255, blue: 80/255, alpha: 1.0))
        .fontSize(of: 15.0)
        .build()
    
    let roleLabel       = UILabelFactory(text: "")
        .numberOf(lines: 0)
        .textAlignment(with: .center)
        .textColor(with: UIColor(red: 123/255, green: 123/255, blue: 123/255, alpha: 1.0))
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
        addSubview(NameLabel)
        addSubview(roleLabel)
        setUpConstraintsForLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpConstraintsForLayout(){
        roleLabel.layoutAnchor(top: nil, left: nil, bottom: bottomAnchor, right: nil, centerX: centerXAnchor, centerY: nil, paddingTop: 0.0, paddingLeft: 0.0, paddingBottom: 5.0, paddingRight: 0.0, width: 180.0, height: 25.0, enableInsets: true)
        NameLabel.layoutAnchor(top: topAnchor, left: leftAnchor, bottom: roleLabel.topAnchor, right: rightAnchor, centerX: centerXAnchor, centerY: nil, paddingTop: 0.0, paddingLeft: 0.0, paddingBottom: 0.0, paddingRight: 0.0, width: 0.0, height: 0.0, enableInsets: true)
    }
}
