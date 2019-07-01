//
//  ProfileInformationScreenController.swift
//  SpecaWorx
//
//  Created by Anil Kumar on 20/05/19.
//  Copyright © 2019 Anil Kumar. All rights reserved.
//

import UIKit

class ProfileInformationScreenController: UIViewController ,UIImagePickerControllerDelegate,UINavigationControllerDelegate, UITextFieldDelegate{
    
    lazy var appLogo          = customImageClass()
    lazy var welcomeView      = customUIViewClass()
    lazy var signUpView       = customUIViewClass()
    lazy var bottomBarView    = customUIViewClass()
    lazy var imagePicker      = UIImagePickerController()
    let scrollView: UIScrollView = {
        let v = UIScrollView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.alwaysBounceVertical = true
        v.alwaysBounceHorizontal = false
        return v
    }()
    
    let numberToolbar             = UIToolbar(frame:CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
    private let menuBack      = UIButtonFactory(title: "")
        .backgroundImage(with: UIImage(named: "back-icon")!)
        //        .addTarget(self, action: #selector(backButtontapped), for: .touchUpInside)
        .build()
    
    private let titleLabel    = UILabelFactory(text: "PROFILE INFORMATION")
        .numberOf(lines: 0)
        .textAlignment(with: .left)
        .textColor(with: .white)
        .fontSize(of: 18.0)
        .build()
    
    private let qrHolderLabel = UILabelFactory(text: "QR Holder Information")
        .numberOf(lines: 0)
        .textAlignment(with: .center)
        .textColor(with: .white)
        .fontSize(of: 15.0)
        .build()
    
    private let submitProfile = UIButtonFactory(title: "SUBMIT PROFILE")
        .backgroundColour(with: UIColor(red: 38/255, green: 87/255, blue: 140/255, alpha: 1.0))
        .textColor(with: .white)
        .textFontSize(with: UIFont(name: "Montserrat-Medium", size: 13.0)!)
        .borderColor(with: UIColor(red: 32/255, green: 76/255, blue: 120/255, alpha: 1.0).cgColor)
        .borderThick(with: 1.0)
        .cornerRadious(with: 25.0)
        .addTarget(self, action: #selector(submitProfileTapped), for: .touchUpInside)
        .build()
    
    private let backButton     = UIButtonFactory(title: "Back")
        .textColor(with: .white)
        .textFonts(with: UIFont(name: "Montserrat-Medium", size: 12.0)!)
        .addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
        .build()
    
    private let nameTitle      = UILabelFactory(text: "Your Name")
        .textColor(with: UIColor(red: 128/255, green: 128/255, blue: 128/255, alpha: 1.0))
        .textAlignment(with: .left)
        .fontSize(of: 13.0)
        .build()
    
    private let contactTitle   = UILabelFactory(text: "Contact Number")
        .textColor(with: UIColor(red: 128/255, green: 128/255, blue: 128/255, alpha: 1.0))
        .textAlignment(with: .left)
        .fontSize(of: 13.0)
        .build()
    
    private let uploadPicTitle = UILabelFactory(text: "Upload Picture Of QR Holder")
        .textColor(with: UIColor(red: 128/255, green: 128/255, blue: 128/255, alpha: 1.0))
        .textAlignment(with: .left)
        .fontSize(of: 13.0)
        .build()
    
    private let uploadPicLabel = UILabelFactory(text: "Upload Picture")
        .textColor(with: UIColor(red: 206/255, green: 206/255, blue: 206/255, alpha: 1.0))
        .textAlignment(with: .left)
        .fontSize(of: 16.0)
        .build()
    
    private let holderNameTitle = UILabelFactory(text: "Name of the Holder")
        .textColor(with: UIColor(red: 128/255, green: 128/255, blue: 128/255, alpha: 1.0))
        .textAlignment(with: .left)
        .fontSize(of: 13.0)
        .build()
    
    private let holderAgeTitle  = UILabelFactory(text: "Age Of the Holder")
        .textColor(with: UIColor(red: 128/255, green: 128/255, blue: 128/255, alpha: 1.0))
        .textAlignment(with: .left)
        .fontSize(of: 13.0)
        .build()
    
    private let genderTitle     = UILabelFactory(text: "Gender")
        .textColor(with: UIColor(red: 128/255, green: 128/255, blue: 128/255, alpha: 1.0))
        .textAlignment(with: .left)
        .fontSize(of: 13.0)
        .build()
    
    let maleButton              = UIButtonFactory(title: "")
        .build()
    
    let femaleButton            = UIButtonFactory(title: "")
        .build()
    
    private let maleLabel       = UILabelFactory(text: "Male")
        .numberOf(lines: 0)
        .textAlignment(with: .left)
        .textColor(with: .lightGray)
        .fontSize(of: 12.0)
        .build()
    
    private let femaleLabel     = UILabelFactory(text: "Female")
        .numberOf(lines: 0)
        .textAlignment(with: .left)
        .textColor(with: .lightGray)
        .fontSize(of: 12.0)
        .build()
    
    private let medicineTitle   = UILabelFactory(text: "Medicines")
        .textColor(with: UIColor(red: 128/255, green: 128/255, blue: 128/255, alpha: 1.0))
        .textAlignment(with: .left)
        .fontSize(of: 13.0)
        .build()
    
    private let commentsTitle   = UILabelFactory(text: "Any Additional Comments")
        .textColor(with: UIColor(red: 128/255, green: 128/255, blue: 128/255, alpha: 1.0))
        .textAlignment(with: .left)
        .fontSize(of: 13.0)
        .build()
    
    public let nameField      = TextField()
    public let contactField   = TextField()
    public let uploadPic      = customImageClass()
    public let holderField    = TextField()
    public let ageField       = TextField()
    public let medicineField  = TextField()
    public let commentsField  = TextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        appLogo.image                 = UIImage(named: "specaworx-logo")
        welcomeView.backgroundColor   = UIColor(red: 40/255, green: 92/255, blue: 148/255, alpha: 1.0)
        signUpView.backgroundColor    = UIColor(red: 50/255, green: 113/255, blue: 180/255, alpha: 1.0)
        bottomBarView.backgroundColor = UIColor(red: 50/255, green: 113/255, blue: 180/255, alpha: 1.0)
        scrollView.backgroundColor    = .clear
        imagePicker.delegate          = self
        uploadPic.image               = UIImage(named: "Profile_Icon")
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(chooseProfileImagetapped))
        uploadPic.isUserInteractionEnabled = true
        uploadPic.addGestureRecognizer(tapGesture)
        maleButton.setBackgroundImage(UIImage(named: "CheckRadio"), for: .normal)
        femaleButton.setBackgroundImage(UIImage(named: "UncheckRadio"), for: .normal)
        maleButton.addTarget(self, action: #selector(maleButtonTapped), for: .touchUpInside)
        femaleButton.addTarget(self, action: #selector(femaleButtontapped), for: .touchUpInside)
        numberToolbar.barStyle = .default
        numberToolbar.items = [
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
            UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(didTabDoneBarButton))]
        numberToolbar.sizeToFit()
        setUpLayoutViews()
        setUpConstraintsForLayout()
        textFieldProperties()
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if editFlag{
            editFlag = false
            submitProfile.setTitle("Update", for: .normal)
            profileCompletionValidation()
        }
    }
    
    func profileCompletionValidation(){
        //        if let data = UserDefaults.standard.value(forKey: currentLogInMail) as? [String : [String : Any]]{
        //            if let UserName = data[currentLogInMail]?["UserName"] as? String{
        //                nameField.text = UserName
        //            }
        //            if let ContactNo = data[currentLogInMail]?["ContactNo"] as? String{
        //                contactField.text = ContactNo
        //            }
        //            if let HolderName = data[currentLogInMail]?["HolderName"] as? String{
        //                holderField.text = HolderName
        //            }
        //            if let HolderAge = data[currentLogInMail]?["HolderAge"] as? String{
        //                ageField.text = HolderAge
        //            }
        //            if let HolderMedicine = data[currentLogInMail]?["HolderMedicine"] as? String{
        //                medicineField.text = HolderMedicine
        //            }
        //            if let HolderComments = data[currentLogInMail]?["HolderComments"] as? String{
        //                commentsField.text = HolderComments
        //            }
        //        }
        if let name = UserDefaults.standard.value(forKey: "qrUsername") as? String{
            nameField.text = name
        }
        
        if let contact = UserDefaults.standard.value(forKey: "qrHolderContact") as? String{
            contactField.text = contact
        }
        
        if let HolderName = UserDefaults.standard.value(forKey: "qrHolderName") as? String{
            holderField.text = HolderName.uppercased()
        }
        if let HolderAge = UserDefaults.standard.value(forKey: "qrholderAge") as? String{
            ageField.text = HolderAge
        }
        
        if let HolderMedicine = UserDefaults.standard.value(forKey: "qrHoldermedicine") as? String{
            medicineField.text = HolderMedicine
        }
        
        if let HolderComments = UserDefaults.standard.value(forKey: "qrholderComments") as? String{
            commentsField.text = HolderComments
        }
        
        if let imageData = UserDefaults.standard.value(forKey: "qrHolderImage") as? Data{
            let image: UIImage = UIImage(data: imageData)!
            uploadPic.image    = image
        }
    }
    
    @objc func didTabDoneBarButton(){
        ageField.resignFirstResponder()
        contactField.resignFirstResponder()
    }
    
    @objc func didTapBackButton(){
        profileInformation.name = nameField.text!
        profileInformation.ContactNo = contactField.text!
        profileInformation.holderName = holderField.text!
        profileInformation.holderAge = ageField.text!
        profileInformation.medicine = medicineField.text!
        profileInformation.comments = commentsField.text!
        if let img = uploadPic.image {
            let data = img.jpegData(compressionQuality: 1)
            profileInformation.profileImage = data
        }
        
        let updateValues = ["UserName": profileInformation.name, "ContactNo": profileInformation.ContactNo, "ProfileImage": profileInformation.profileImage as Any, "HolderName": profileInformation.holderName, "HolderAge": profileInformation.holderAge, "HolderGender": profileInformation.holdergender,"HolderMedicine": profileInformation.medicine, "HolderComments": profileInformation.comments,"ProfileCompletion": "0"] as [String:Any]
        profileInfo.updateValue(updateValues, forKey: currentLogInMail)
        UserDefaults.standard.set(profileInfo, forKey: currentLogInMail)
        navigationController?.popToRootViewController(animated: true)
    }
    
    //    SubmitProfileTapped
    @objc func submitProfileTapped(){
        if Reachability.isConnectedToNetwork() {
            submitProfile.loadingIndicator(show: true)
            submitProfile.setTitle("", for: .normal)
            let validation = validateTextFeilds()
            if validation {
                if gender == true{
                    profileInformation.holdergender = "male"
                }else if gender == false{
                    profileInformation.holdergender = "female"
                }
                
                let updateValues = ["UserName": profileInformation.name, "ContactNo": profileInformation.ContactNo, "ProfileImage": profileInformation.profileImage as Any, "HolderName": profileInformation.holderName, "HolderAge": profileInformation.holderAge, "HolderGender": profileInformation.holdergender,"HolderMedicine": profileInformation.medicine, "HolderComments": profileInformation.comments,"ProfileCompletion": "1"] as [String:Any]
                
                profileInfo.updateValue(updateValues, forKey: currentLogInMail)
                UserDefaults.standard.set(profileInfo, forKey: currentLogInMail)
                inCompleteProfile = false
                profileInformationSetUp(user_name: profileInformation.name, user_contact: profileInformation.ContactNo, picture: profileInformation.profileImage!, holder_name: profileInformation.holderName, holder_age: profileInformation.holderAge, gender: profileInformation.holdergender, medicines: profileInformation.medicine, comments: profileInformation.comments,api_token: profileInformation.token)
            }
        }
    }
    //ImagePicker Function
    @objc func chooseProfileImagetapped(){
        
        let alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
            self.openCamera()
        }))
        
        alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { _ in
            self.openGallary()
        }))
        
        alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func openCamera()
    {
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera))
        {
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
        else
        {
            let alert  = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func openGallary()
    {
        imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
        imagePicker.allowsEditing = true
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    @objc func maleButtonTapped(){
        if gender == false{
            gender = true
            maleButton.setBackgroundImage(UIImage(named: "CheckRadio"), for: .normal)
            femaleButton.setBackgroundImage(UIImage(named: "UncheckRadio"), for: .normal)
        }
    }
    
    @objc func femaleButtontapped(){
        if gender == true{
            gender = false
            maleButton.setBackgroundImage(UIImage(named: "UncheckRadio"), for: .normal)
            femaleButton.setBackgroundImage(UIImage(named: "CheckRadio"), for: .normal)
        }
    }
    
    //ImagePicker Delegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickerImage  = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            uploadPic.image = pickerImage
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func profileInformationSetUp(user_name: String, user_contact: String, picture: Data, holder_name:String , holder_age:String, gender:String, medicines:String, comments:String, api_token:String){
        
        Networking.shared.profileSetUp(user_name: user_name, user_contact: user_contact, picture: picture, holder_name: holder_name, holder_age: holder_age, gender: gender, medicines: medicines, comments: comments,api_token: api_token) { (success, error, result, token,userName,contact,holdername,age,gender,medicine,comments,picture) in
            if success {
                profileInformation.token             = token
                qrHolderInformation.qrCode           = result
                qrHolderInformation.qrUsername       = userName
                qrHolderInformation.qrHolderContact  = contact
                qrHolderInformation.qrHolderName     = holdername
                qrHolderInformation.qrholderAge      = age
                qrHolderInformation.qrHolderGender   = gender
                qrHolderInformation.qrHoldermedicine = medicine
                qrHolderInformation.qrholderComments = comments
                qrHolderInformation.qrHolderImage    = picture
                UserDefaults.standard.set(userName, forKey: "qrUsername")
                UserDefaults.standard.set(contact, forKey: "qrHolderContact")
                UserDefaults.standard.set(holdername, forKey: "qrHolderName")
                UserDefaults.standard.set(age, forKey: "qrholderAge")
                UserDefaults.standard.set(gender, forKey: "qrHolderGender")
                UserDefaults.standard.set(medicine, forKey: "qrHoldermedicine")
                UserDefaults.standard.set(comments, forKey: "qrholderComments")
                UserDefaults.standard.set(picture, forKey: "qrHolderImage")
                UserDefaults.standard.set(result, forKey: "qrCodeLink")
                
                self.submitProfile.loadingIndicator(show: false)
                self.submitProfile.setTitle("CREATE PROFILE", for: .normal)
                let url = URL(string: result)
                if let data = try? Data(contentsOf: url!)
                {
                    qrHolderInformation.qrImage = data
                    qrCode.updateValue(data, forKey: currentLogInMail)
                    UserDefaults.standard.set(data, forKey: "qrCode")
                }
                let imageUrl = URL(string: picture)
                if let data = try? Data(contentsOf: imageUrl!)
                {
                    //                    qrHolderInformation.qrImage = data
                    //                    qrCode.updateValue(data, forKey: currentLogInMail)
                    UserDefaults.standard.set(data, forKey: "qrHolderImage")
                }
                self.submitProfile.loadingIndicator(show: false)
                self.submitProfile.setTitle("SUBMIT PROFILE", for: .normal)
                self.showConfirmAlert(title: "", message: "Profile Created Successfully", buttonTitle: "Ok", buttonStyle: .default, confirmAction: self.alertAction)
            }else {
                self.showConfirmAlert(title: "", message: "Something Went Wrong", buttonTitle: "Ok", buttonStyle: .default, confirmAction: { (action) in
                    self.navigationController?.popToRootViewController(animated: true)
                })
            }
        }
    }
    
    func alertAction(action: UIAlertAction){
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "QRProfileInfoScreenController") as? QRProfileInfoScreenController
        self.navigationController?.pushViewController(vc!, animated: true)
    }
}

extension ProfileInformationScreenController{
    
    func textFieldProperties(){
        nameField.delegate = self
        nameField.autocorrectionType = .no
        nameField.borderStyle = .line
        nameField.layer.borderColor = UIColor(red: 234/255, green: 234/255, blue: 234/255, alpha: 1.0).cgColor
        nameField.layer.borderWidth = 1.0
        nameField.attributedPlaceholder = NSAttributedString(string: "Your name here", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 0.28, green: 0.33, blue: 0.40, alpha: 1)])
        contactField.delegate = self
        contactField.autocorrectionType = .no
        contactField.borderStyle = .line
        contactField.keyboardType = .phonePad
        contactField.inputAccessoryView = numberToolbar
        contactField.layer.borderColor = UIColor(red: 234/255, green: 234/255, blue: 234/255, alpha: 1.0).cgColor
        contactField.layer.borderWidth = 1.0
        contactField.attributedPlaceholder = NSAttributedString(string: "Contact number here", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 0.28, green: 0.33, blue: 0.40, alpha: 1)])
        holderField.delegate = self
        holderField.autocorrectionType = .no
        holderField.borderStyle = .line
        holderField.layer.borderColor = UIColor(red: 234/255, green: 234/255, blue: 234/255, alpha: 1.0).cgColor
        holderField.layer.borderWidth = 1.0
        holderField.attributedPlaceholder = NSAttributedString(string: "Holder's name here", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 0.28, green: 0.33, blue: 0.40, alpha: 1)])
        ageField.delegate = self
        ageField.autocorrectionType = .no
        ageField.borderStyle = .line
        ageField.keyboardType = .numberPad
        ageField.inputAccessoryView = numberToolbar
        ageField.layer.borderColor = UIColor(red: 234/255, green: 234/255, blue: 234/255, alpha: 1.0).cgColor
        ageField.layer.borderWidth = 1.0
        ageField.attributedPlaceholder = NSAttributedString(string: "Holder's age here", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 0.28, green: 0.33, blue: 0.40, alpha: 1)])
        medicineField.delegate = self
        medicineField.autocorrectionType = .no
        medicineField.borderStyle = .line
        medicineField.layer.borderColor = UIColor(red: 234/255, green: 234/255, blue: 234/255, alpha: 1.0).cgColor
        medicineField.layer.borderWidth = 1.0
        medicineField.attributedPlaceholder = NSAttributedString(string: "Medicines If any", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 0.28, green: 0.33, blue: 0.40, alpha: 1)])
        commentsField.delegate = self
        commentsField.autocorrectionType = .no
        commentsField.borderStyle = .line
        commentsField.layer.borderColor = UIColor(red: 234/255, green: 234/255, blue: 234/255, alpha: 1.0).cgColor
        commentsField.layer.borderWidth = 1.0
        commentsField.attributedPlaceholder = NSAttributedString(string: "Comments", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 0.28, green: 0.33, blue: 0.40, alpha: 1)])
    }
    
    override func viewDidLayoutSubviews() {
        let screensize: CGRect = UIScreen.main.bounds
        let screenWidth = screensize.width
        let screenHeight = screensize.height
        scrollView.contentSize = CGSize(width: screenWidth, height: screenHeight)
    }
    
    func setUpLayoutViews(){
        view.addSubview(appLogo)
        view.addSubview(welcomeView)
        view.addSubview(signUpView)
        signUpView.addSubview(qrHolderLabel)
        welcomeView.addSubview(menuBack)
        welcomeView.addSubview(titleLabel)
        view.addSubview(bottomBarView)
        bottomBarView.addSubview(submitProfile)
        bottomBarView.addSubview(backButton)
        view.addSubview(scrollView)
        scrollView.addSubview(nameTitle)
        scrollView.addSubview(nameField)
        scrollView.addSubview(contactTitle)
        scrollView.addSubview(contactField)
        scrollView.addSubview(uploadPic)
        scrollView.addSubview(uploadPicLabel)
        scrollView.addSubview(uploadPicTitle)
        scrollView.addSubview(holderNameTitle)
        scrollView.addSubview(holderField)
        scrollView.addSubview(holderAgeTitle)
        scrollView.addSubview(ageField)
        scrollView.addSubview(genderTitle)
        scrollView.addSubview(maleButton)
        scrollView.addSubview(femaleButton)
        scrollView.addSubview(maleLabel)
        scrollView.addSubview(femaleLabel)
        scrollView.addSubview(medicineTitle)
        scrollView.addSubview(medicineField)
        scrollView.addSubview(commentsTitle)
        scrollView.addSubview(commentsField)
    }
    
    func setUpConstraintsForLayout(){
        switch UIDevice().type {
        case .iPhoneX,.iPhoneXS,.iPhoneXSmax,.iPhoneXR:
            appLogo.layoutAnchor(top: view.topAnchor, left: nil, bottom: nil, right: nil, centerX: view.centerXAnchor, centerY: nil, paddingTop: 65.0, paddingLeft: 0.0, paddingBottom: 0.0, paddingRight: 0.0, width: 150.0, height: 30.0, enableInsets: true)
            bottomBarView.layoutAnchor(top: nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, centerX: nil, centerY: nil, paddingTop: 0.0, paddingLeft: 0.0, paddingBottom: 0.0, paddingRight: 0.0, width: 0.0, height: view.frame.size.height/5.5, enableInsets: true)
        default:
            appLogo.layoutAnchor(top: view.topAnchor, left: nil, bottom: nil, right: nil, centerX: view.centerXAnchor, centerY: nil, paddingTop: 40.0, paddingLeft: 0.0, paddingBottom: 0.0, paddingRight: 0.0, width: 150.0, height: 30.0, enableInsets: true)
            bottomBarView.layoutAnchor(top: nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, centerX: nil, centerY: nil, paddingTop: 0.0, paddingLeft: 0.0, paddingBottom: 0.0, paddingRight: 0.0, width: 0.0, height: view.frame.size.height/6, enableInsets: true)
        }
        welcomeView.layoutAnchor(top: appLogo.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, centerX: nil, centerY: nil, paddingTop: 15.0, paddingLeft: 0.0, paddingBottom: 0.0, paddingRight: 0.0, width: 0.0, height: 50.0, enableInsets: true)
        menuBack.layoutAnchor(top: welcomeView.topAnchor, left: welcomeView.leftAnchor, bottom: welcomeView.bottomAnchor, right: nil, centerX: nil, centerY: nil, paddingTop: 0.0, paddingLeft: 0.0, paddingBottom: 0.0, paddingRight: 0.0, width: 50.0, height: 0.0, enableInsets: true)
        titleLabel.layoutAnchor(top: nil, left: menuBack.rightAnchor, bottom: nil, right: nil, centerX: nil, centerY: menuBack.centerYAnchor, paddingTop: 0.0, paddingLeft: 10.0, paddingBottom: 0.0, paddingRight: 0.0, width: 0.0, height: 0.0, enableInsets: true)
        signUpView.layoutAnchor(top: welcomeView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, centerX: nil, centerY: nil, paddingTop: 0.0, paddingLeft: 0.0, paddingBottom: 0.0, paddingRight: 0.0, width: 0.0, height: 60.0, enableInsets: true)
        qrHolderLabel.layoutAnchor(top: nil, left: nil, bottom: nil, right: nil, centerX: signUpView.centerXAnchor, centerY: signUpView.centerYAnchor, paddingTop: 0.0, paddingLeft: 0.0, paddingBottom: 0.0, paddingRight: 0.0, width: 0.0, height: 0.0, enableInsets: true)
        scrollView.layoutAnchor(top: signUpView.bottomAnchor, left: view.leftAnchor, bottom: bottomBarView.topAnchor, right: view.rightAnchor, centerX: nil, centerY: nil, paddingTop: 0.0, paddingLeft: 0.0, paddingBottom: 0.0, paddingRight: 0.0, width: 0.0, height: 0.0, enableInsets: true)
        nameTitle.layoutAnchor(top: scrollView.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, centerX: nil, centerY: nil, paddingTop: 35.0, paddingLeft: 30.0, paddingBottom: 0.0, paddingRight: 30.0, width: 0.0, height: 25.0, enableInsets: true)
        nameField.layoutAnchor(top: nameTitle.bottomAnchor, left: nameTitle.leftAnchor, bottom: nil, right: nameTitle.rightAnchor, centerX: nil, centerY: nil, paddingTop: 5.0, paddingLeft: 0.0, paddingBottom: 0.0, paddingRight: 0.0, width: 0.0, height: 40.0, enableInsets: true)
        contactTitle.layoutAnchor(top: nameField.bottomAnchor, left: nameTitle.leftAnchor, bottom: nil, right: nameTitle.rightAnchor, centerX: nil, centerY: nil, paddingTop: 10.0, paddingLeft: 0.0, paddingBottom: 0.0, paddingRight: 0.0, width: 0.0, height: 25.0, enableInsets: true)
        contactField.layoutAnchor(top: contactTitle.bottomAnchor, left: nameTitle.leftAnchor, bottom: nil, right: nameTitle.rightAnchor, centerX: nil, centerY: nil, paddingTop: 5.0, paddingLeft: 0.0, paddingBottom: 0.0, paddingRight: 0.0, width: 0.0, height: 40.0, enableInsets: true)
        uploadPicTitle.layoutAnchor(top: contactField.bottomAnchor, left: nameTitle.leftAnchor, bottom: nil, right: nameTitle.rightAnchor, centerX: nil, centerY: nil, paddingTop: 10.0, paddingLeft: 0.0, paddingBottom: 0.0, paddingRight: 0.0, width: 0.0, height: 25.0, enableInsets: true)
        uploadPic.layoutAnchor(top: uploadPicTitle.bottomAnchor, left: nameTitle.leftAnchor, bottom: nil, right: nil, centerX: nil, centerY: nil, paddingTop: 5.0, paddingLeft: 0.0, paddingBottom: 0.0, paddingRight: 0.0, width: 70.0, height: 70.0, enableInsets: true)
        uploadPicLabel.layoutAnchor(top: nil, left: uploadPic.rightAnchor, bottom: nil, right: nil, centerX: nil, centerY: uploadPic.centerYAnchor, paddingTop: 0.0, paddingLeft: 10.0, paddingBottom: 0.0, paddingRight: 0.0, width: 0.0, height: 0.0, enableInsets: true)
        holderNameTitle.layoutAnchor(top: uploadPic.bottomAnchor, left: nameTitle.leftAnchor, bottom: nil, right: nameTitle.rightAnchor, centerX: nil, centerY: nil, paddingTop: 10.0, paddingLeft: 0.0, paddingBottom: 0.0, paddingRight: 0.0, width: 0.0, height: 25.0, enableInsets: true)
        holderField.layoutAnchor(top: holderNameTitle.bottomAnchor, left: nameTitle.leftAnchor, bottom: nil, right: nameTitle.rightAnchor, centerX: nil, centerY: nil, paddingTop: 5.0, paddingLeft: 0.0, paddingBottom: 0.0, paddingRight: 0.0, width: 0.0, height: 40.0, enableInsets: true)
        holderAgeTitle.layoutAnchor(top: holderField.bottomAnchor, left: nameTitle.leftAnchor, bottom: nil, right: nameTitle.rightAnchor, centerX: nil, centerY: nil, paddingTop: 10.0, paddingLeft: 0.0, paddingBottom: 0.0, paddingRight: 0.0, width: 0.0, height: 25.0, enableInsets: true)
        ageField.layoutAnchor(top: holderAgeTitle.bottomAnchor, left: nameTitle.leftAnchor, bottom: nil, right: nameTitle.rightAnchor, centerX: nil, centerY: nil, paddingTop: 5.0, paddingLeft: 0.0, paddingBottom: 0.0, paddingRight: 0.0, width: 0.0, height: 40.0, enableInsets: true)
        genderTitle.layoutAnchor(top: ageField.bottomAnchor, left: nameTitle.leftAnchor, bottom: nil, right: nameTitle.rightAnchor, centerX: nil, centerY: nil, paddingTop: 10.0, paddingLeft: 0.0, paddingBottom: 0.0, paddingRight: 0.0, width: 0.0, height: 25.0, enableInsets: true)
        maleButton.layoutAnchor(top: genderTitle.bottomAnchor, left: nameTitle.leftAnchor, bottom: nil, right: nil, centerX: nil, centerY: nil, paddingTop: 10.0, paddingLeft: 0.0, paddingBottom: 0.0, paddingRight: 0.0, width: 30.0, height: 30.0, enableInsets: true)
        maleLabel.layoutAnchor(top: nil, left: maleButton.rightAnchor, bottom: nil, right: nil, centerX: nil, centerY: maleButton.centerYAnchor, paddingTop: 0.0, paddingLeft: 10.0, paddingBottom: 0.0, paddingRight: 0.0, width: 30.0, height: 0.0, enableInsets: true)
        femaleButton.layoutAnchor(top: genderTitle.bottomAnchor, left: maleLabel.rightAnchor, bottom: nil, right: nil, centerX: nil, centerY: nil, paddingTop: 10.0, paddingLeft: 10.0, paddingBottom: 0.0, paddingRight: 0.0, width: 30.0, height: 30.0, enableInsets: true)
        femaleLabel.layoutAnchor(top: nil, left: femaleButton.rightAnchor, bottom: nil, right: nil, centerX: nil, centerY: femaleButton.centerYAnchor, paddingTop: 0.0, paddingLeft: 10.0, paddingBottom: 0.0, paddingRight: 0.0, width: 50.0, height: 0.0, enableInsets: true)
        medicineTitle.layoutAnchor(top: maleButton.bottomAnchor, left: nameTitle.leftAnchor, bottom: nil, right: nameTitle.rightAnchor, centerX: nil, centerY: nil, paddingTop: 10.0, paddingLeft: 0.0, paddingBottom: 0.0, paddingRight: 0.0, width: 0.0, height: 25.0, enableInsets: true)
        medicineField.layoutAnchor(top: medicineTitle.bottomAnchor, left: nameTitle.leftAnchor, bottom: nil, right: nameTitle.rightAnchor, centerX: nil, centerY: nil, paddingTop: 5.0, paddingLeft: 0.0, paddingBottom: 0.0, paddingRight: 0.0, width: 0.0, height: 40.0, enableInsets: true)
        commentsTitle.layoutAnchor(top: medicineField.bottomAnchor, left: nameTitle.leftAnchor, bottom: nil, right: nameTitle.rightAnchor, centerX: nil, centerY: nil, paddingTop: 10.0, paddingLeft: 0.0, paddingBottom: 0.0, paddingRight: 0.0, width: 0.0, height: 25.0, enableInsets: true)
        commentsField.layoutAnchor(top: commentsTitle.bottomAnchor, left: nameTitle.leftAnchor, bottom: nil, right: nameTitle.rightAnchor, centerX: nil, centerY: nil, paddingTop: 5.0, paddingLeft: 0.0, paddingBottom: 0.0, paddingRight: 0.0, width: 0.0, height: 80.0, enableInsets: true)
        submitProfile.layoutAnchor(top: bottomBarView.topAnchor, left: nil, bottom: nil, right: nil, centerX: bottomBarView.centerXAnchor, centerY: nil, paddingTop: 20.0, paddingLeft: 0.0, paddingBottom: 0.0, paddingRight: 0.0, width: view.frame.size.width/1.5, height: 50.0, enableInsets: true)
        backButton.layoutAnchor(top: submitProfile.bottomAnchor, left: nil, bottom: nil, right: nil, centerX: submitProfile.centerXAnchor, centerY: nil, paddingTop: 10.0, paddingLeft: 0.0, paddingBottom: 0.0, paddingRight: 0.0, width: 65.0, height: 35.0, enableInsets: true)
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension ProfileInformationScreenController{
    
    func validateTextFeilds() -> Bool{
        removeData()
        
        if nameField.text?.count != 0{
            profileInformation.name = nameField.text!
        }else{
            self.submitProfile.loadingIndicator(show: false)
            self.submitProfile.setTitle("SUBMIT PROFILE", for: .normal)
            showConfirmAlert(title: "", message: "Name Field Cannot be Empty", buttonTitle: "Ok", buttonStyle: .default, confirmAction: nil)
            return false
        }
        
        if contactField.text?.count != 0{
            guard let text = contactField.text else { return false }
            let response = Validation.shared.validate(values: (ValidationType.phoneNo, text))
            switch response{
            case .success:
                profileInformation.ContactNo = contactField.text!
            case .failure(_, let error):
                self.submitProfile.loadingIndicator(show: false)
                self.submitProfile.setTitle("SUBMIT PROFILE", for: .normal)
                showConfirmAlert(title: "", message: error.rawValue, buttonTitle: "Ok", buttonStyle: .default, confirmAction: nil)
            }
        }else{
            self.submitProfile.loadingIndicator(show: false)
            self.submitProfile.setTitle("SUBMIT PROFILE", for: .normal)
            showConfirmAlert(title: "", message: "Contact No cannot be Empty", buttonTitle: "Ok", buttonStyle: .default, confirmAction: nil)
            return false
        }
        
        if let img = uploadPic.image {
            let data = img.jpegData(compressionQuality: 1)
            profileInformation.profileImage = data
        }
        
        if holderField.text?.count != 0{
            profileInformation.holderName = holderField.text!
        }else{
            self.submitProfile.loadingIndicator(show: false)
            self.submitProfile.setTitle("SUBMIT PROFILE", for: .normal)
            showConfirmAlert(title: "", message: "Holder Name Field Cannot Be Empty", buttonTitle: "Ok", buttonStyle: .default, confirmAction: nil)
            return false
        }
        
        if (ageField.text?.count) == 0 || (ageField.text?.count)! > 3{
            self.submitProfile.loadingIndicator(show: false)
            self.submitProfile.setTitle("SUBMIT PROFILE", for: .normal)
            showConfirmAlert(title: "", message: "Holder Age Field Cannot Be Empty", buttonTitle: "Ok", buttonStyle: .default, confirmAction: nil)
            return false
        }else {
            profileInformation.holderAge = ageField.text!
        }
        
        if medicineField.text?.count != 0{
            profileInformation.medicine = medicineField.text!
        }
        
        if commentsField.text?.count != 0{
            profileInformation.comments = commentsField.text!
        }
        return true
    }
    
    func removeData(){
        profileInformation.name         = ""
        profileInformation.ContactNo    = ""
        profileInformation.holderName   = ""
        profileInformation.holderAge    = ""
        profileInformation.medicine     = ""
        profileInformation.comments     = ""
        profileInformation.holdergender = ""
        profileInformation.profileImage?.removeAll()
    }
    
    @objc func keyboardWillShow(notification:NSNotification){
        
        var userInfo = notification.userInfo!
        var keyboardFrame:CGRect = (userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        keyboardFrame = self.view.convert(keyboardFrame, from: nil)
        
        var contentInset:UIEdgeInsets = self.scrollView.contentInset
        contentInset.bottom = keyboardFrame.size.height
        scrollView.contentInset = contentInset
    }
    
    @objc func keyboardWillHide(notification:NSNotification){
        
        let contentInset:UIEdgeInsets = UIEdgeInsets.zero
        scrollView.contentInset = contentInset
    }
}
