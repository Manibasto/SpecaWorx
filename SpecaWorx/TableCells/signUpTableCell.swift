//
//  signUpTableCell.swift
//  SpecaWorx
//
//  Created by Anil Kumar on 17/05/19.
//  Copyright © 2019 Anil Kumar. All rights reserved.
//

import UIKit

class signUpTableCell: UITableViewCell {

    lazy var customView  = customCardViewClass()
    lazy var textField   = TextField()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        textField.delegate = self
        textField.autocorrectionType = .no
        addSubview(customView)
        customView.addSubview(textField)
        
        setUpConstraintsForLayout()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpConstraintsForLayout(){
        customView.layoutAnchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, centerX: nil, centerY: nil, paddingTop: 10.0, paddingLeft: 10.0, paddingBottom: 10.0, paddingRight: 10.0, width: 0.0, height: 0.0, enableInsets: true)
        textField.layoutAnchor(top: customView.topAnchor, left: customView.leftAnchor, bottom: customView.bottomAnchor, right: customView.rightAnchor, centerX: nil, centerY: nil, paddingTop: 0.0, paddingLeft: 0.0, paddingBottom: 0.0, paddingRight: 0.0, width: 0.0, height: 0.0, enableInsets: true)
    }
    
}

extension signUpTableCell: UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
