//
//  QRInfoTableCell.swift
//  SpecaWorx
//
//  Created by Anil Kumar on 21/05/19.
//  Copyright © 2019 Anil Kumar. All rights reserved.
//

import UIKit

class QRInfoTableCell: UITableViewCell {

    lazy var customView = customUIViewClass()
    
    let infoLabel  = UILabelFactory(text: "")
        .numberOf(lines: 0)
        .textAlignment(with: .left)
        .textColor(with: UIColor(red: 72/255, green: 72/255, blue: 72/255, alpha: 1.0))
        .fontSize(of: 16.0)
        .build()
    
    let roleLabel  = UILabelFactory(text: "")
        .numberOf(lines: 0)
        .textAlignment(with: .left)
        .textColor(with: UIColor(red: 111/255, green: 111/255, blue: 111/255, alpha: 1.0))
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
        customView.addSubview(infoLabel)
        customView.addSubview(roleLabel)
        
        setUpConstraintsForLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpConstraintsForLayout(){
        customView.layoutAnchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, centerX: nil, centerY: nil, paddingTop: 5.0, paddingLeft: 5.0, paddingBottom: 5.0, paddingRight: 5.0, width: 0.0, height: 0.0, enableInsets: true)
        infoLabel.layoutAnchor(top: customView.topAnchor, left: customView.leftAnchor, bottom: nil, right: customView.rightAnchor, centerX: nil, centerY: nil, paddingTop: 10.0, paddingLeft: 10.0, paddingBottom: 0.0, paddingRight: 10.0, width: 0.0, height: 20.0, enableInsets: true)
        roleLabel.layoutAnchor(top: infoLabel.bottomAnchor, left: infoLabel.leftAnchor, bottom: nil, right: infoLabel.rightAnchor, centerX: nil, centerY: nil, paddingTop: 0.0, paddingLeft: 0.0, paddingBottom: 0.0, paddingRight: 0.0, width: 0.0, height: 13.0, enableInsets: true)
    }
    
}
