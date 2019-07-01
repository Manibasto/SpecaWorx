//
//  QRIconTableCell.swift
//  SpecaWorx
//
//  Created by Anil Kumar on 21/05/19.
//  Copyright © 2019 Anil Kumar. All rights reserved.
//

import UIKit

class QRIconTableCell: UITableViewCell {

    lazy var customView = customUIViewClass()
    lazy var qrIcon     = customImageClass()
    
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
        customView.addSubview(qrIcon)
        
        setUpConstraintsForLayout()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setUpConstraintsForLayout(){
        
        customView.layoutAnchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, centerX: nil, centerY: nil, paddingTop: 5.0, paddingLeft: 5.0, paddingBottom: 5.0, paddingRight: 5.0, width: 0.0, height: 0.0, enableInsets: true)
        
        qrIcon.layoutAnchor(top: nil, left: nil, bottom: nil, right: nil, centerX: customView.centerXAnchor, centerY: customView.centerYAnchor, paddingTop: 0.0, paddingLeft: 0.0, paddingBottom: 0.0, paddingRight: 0.0, width: 100.0, height: 100.0, enableInsets: true)
    }

}
