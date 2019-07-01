//
//  AboutScreenControllerViewController.swift
//  SpecaWorx
//
//  Created by Anil Kumar on 08/06/19.
//  Copyright © 2019 Anil Kumar. All rights reserved.
//

import UIKit

class AboutScreenControllerViewController: UIViewController {

    private let titleLabel      = UILabelFactory(text: "About Speca Worx")
        .numberOf(lines: 0)
        .fontSize(of: 20.0)
        .textAlignment(with: .left)
        .textColor(with: .black)
        .build()
    
    private let backButton      = UIButtonFactory(title: "Back")
        .addTarget(self, action: #selector(didTapBack), for: .touchUpInside)
        .setTitileColour(with: .blue)
        .textAlignmentButton(with: .left)
        .build()
    
    private let descriptionText = UITextView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        textViewProperty()
        view.addSubview(titleLabel)
        view.addSubview(backButton)
        view.addSubview(descriptionText)
        
        switch UIDevice().type {
        case .iPhoneX,.iPhoneXS,.iPhoneXSmax,.iPhoneXR:
            titleLabel.layoutAnchor(top: view.topAnchor, left: nil, bottom: nil, right: nil, centerX: view.centerXAnchor, centerY: nil, paddingTop: 40.0, paddingLeft: 0.0, paddingBottom: 0.0, paddingRight: 0.0, width: 0.0, height: 60.0, enableInsets: true)
            backButton.layoutAnchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: nil, centerX: nil, centerY: nil, paddingTop: 55.0, paddingLeft: 0.0, paddingBottom: 0.0, paddingRight: 0.0, width: 80.0, height: 40.0, enableInsets: true)
        default:
            titleLabel.layoutAnchor(top: view.topAnchor, left: nil, bottom: nil, right: nil, centerX: view.centerXAnchor, centerY: nil, paddingTop: 20.0, paddingLeft: 0.0, paddingBottom: 0.0, paddingRight: 0.0, width: 0.0, height: 0.0, enableInsets: true)
            backButton.layoutAnchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: nil, centerX: nil, centerY: nil, paddingTop: 35.0, paddingLeft: 0.0, paddingBottom: 0.0, paddingRight: 0.0, width: 80.0, height: 40.0, enableInsets: true)
        }
        descriptionText.layoutAnchor(top: titleLabel.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, centerX: nil, centerY: nil, paddingTop: 10.0, paddingLeft: 0.0, paddingBottom: 0.0, paddingRight: 0.0, width: 0.0, height: 0.0, enableInsets: true)
        
    }
    
    @objc func didTapBack(){
        navigationController?.popViewController(animated: true)
    }
    
    func textViewProperty(){
        descriptionText.translatesAutoresizingMaskIntoConstraints = false
        descriptionText.text = "Speca Worx (SW) is an awareness and communication/prevention platform, built to help streamline identification and prevent misunderstandings for individuals who have a spectrum disorder, or an inability to communicate or advocate for themselves. We offer different wearable products that are complimented by our Speca Worx app.\n\nSpeca Worx allows you to create a profile on the app and input vital information about the individual wearing one of the products. This information includes the guardian/advocate contact information, the name and a picture of the user of the wearable product, medicines if any; and any additional information that may be helpful. This may include what they react to, or how to communicate with the individual (that information is optional). All of the SW products are sold on this app.\n\nThe mobile app will allow the guardian/advocate to print out a QR code (Quick Response Code, also known as a bar code) with a unique number sequence underneath. The QR code is to be printed and then placed in a clear plastic pocket inside the wearable product as a small cardboard or piece of paper. This makes it easily accessible to scan the QR code or extract the sequenced number. With this information, an emergency service professional, or helpful bystander can pull up the profile in connection and get in contact with the guardian/advocate, or have an insight on how to better help the individual wearing the product if need be.\n\nAt Speca Worx, we are intentional in our pursuit to make better products for this underserved community. We will continue to evolve our platform and resources to better serve those who need advocacy and a voice."
        descriptionText.textContainerInset.top = 10.0
        descriptionText.textContainerInset.left = 10.0
        descriptionText.textContainerInset.bottom = 10.0
        descriptionText.textContainerInset.right = 10.0
        descriptionText.isEditable = false
        
    }
}

class UITextViewPadding : UITextView {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        textContainerInset = UIEdgeInsets(top: 8, left: 4, bottom: 8, right: 4)
    }
}
