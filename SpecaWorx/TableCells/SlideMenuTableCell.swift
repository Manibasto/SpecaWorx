//
//  SlideMenuTableCell.swift
//  SpecaWorx
//
//  Created by Anil Kumar on 17/05/19.
//  Copyright © 2019 Anil Kumar. All rights reserved.
//

import UIKit

class SlideMenuTableCell: UITableViewCell {

    lazy var icon  = customImageClass()
    lazy var label = customLabelClass()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = UIColor(red: 8/255, green: 30/255, blue: 49/255, alpha: 1.0)
        selectionStyle = .none
        
        addSubview(icon)
        addSubview(label)
        icon.tintColor = UIColor.white
        
        setUpConstraintsForLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpConstraintsForLayout(){
        icon.layoutAnchor(top: nil, left: leftAnchor, bottom: nil, right: nil, centerX: nil, centerY: centerYAnchor, paddingTop: 0.0, paddingLeft: 30.0, paddingBottom: 0.0, paddingRight: 0.0, width: 25.0, height: 25.0, enableInsets: true)
        label.layoutAnchor(top: nil, left: icon.rightAnchor, bottom: nil, right: nil, centerX: nil, centerY: icon.centerYAnchor, paddingTop: 0.0, paddingLeft: 20.0, paddingBottom: 0.0, paddingRight: 0.0, width: 0.0, height: 0.0, enableInsets: true)
    }
}
