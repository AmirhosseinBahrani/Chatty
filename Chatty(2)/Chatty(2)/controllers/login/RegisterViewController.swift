//
//  RegisterViewController.swift
//  Chatty(2)
//
//  Created by Amirhossein's macbook pro on 3/24/21.
//

import UIKit
import Alamofire

class RegisterViewController: UIViewController {
    
    
    private let scrollview : UIScrollView = {
        let scrollview = UIScrollView()
        scrollview.clipsToBounds = true
        scrollview.backgroundColor = UIColor(red: 0.11, green: 0.13, blue: 0.18, alpha: 1.00)
        return scrollview
    }()
    
    private let imageview : UIImageView = {
        let imageview = UIImageView()
        imageview.image = UIImage(systemName: "person")
        imageview.tintColor = .gray
        imageview.contentMode = .scaleAspectFit
        imageview.layer.masksToBounds = true
        imageview.layer.borderColor = UIColor.gray.cgColor
        imageview.layer.borderWidth = 1
        return imageview
    }()

    private let UsernameField : UITextField = {
        let field = UITextField()
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .continue
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        field.leftViewMode = .always
        field.backgroundColor = .secondarySystemBackground
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.placeholder = "Enter your Username"
        return field
    }()
    
    private let passwordField : UITextField = {
        let pfield = UITextField()
        pfield.autocapitalizationType = .none
        pfield.autocorrectionType = .no
        pfield.returnKeyType = .done
        pfield.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        pfield.leftViewMode = .always
        pfield.backgroundColor = .secondarySystemBackground
        pfield.layer.cornerRadius = 12
        pfield.layer.borderWidth = 1
        pfield.layer.borderColor = UIColor.lightGray.cgColor
        pfield.placeholder = "Password"
        pfield.isSecureTextEntry = true
        pfield.passwordRules = UITextInputPasswordRules(descriptor: "allowed: upper, lower, digit, [-().&@?__'__#,/&quot;+]; minlength: 8;")
        return pfield
    }()
    
    
    private let showpassword : UIButton = {
        let btn = UIButton()
        btn.setTitle("Show Paaword", for: .normal)
        btn.setTitleColor(.red, for: .normal)
        btn.layer.borderWidth = 1
        btn.layer.borderColor = .init(srgbRed: 0, green: 255, blue: 255, alpha: 0)
        btn.setImage(UIImage(systemName: "lock.circle"), for: .normal)
        return btn
    }()
    
    private let registerbutton : UIButton = {
        let button = UIButton()
        button.setTitle("Register", for: .normal)
        button.backgroundColor = .systemGreen
        button.setTitleColor(.secondarySystemBackground, for: .normal)
        button.layer.cornerRadius = 12
        button.layer.masksToBounds = true
        button.titleLabel?.font = .systemFont(ofSize: 20,weight : .bold)
        return button
    }()
    
    let gradient = CAGradientLayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = false
        navigationController?.isToolbarHidden = true
        passwordField.addSubview(showpassword)
        title = "Register"
        view.backgroundColor = scrollview.backgroundColor
        self.navigationController?.navigationBar.barTintColor = scrollview.backgroundColor
        registerbutton.addTarget(self, action: #selector(Register), for: .touchUpInside)
        
        UsernameField.delegate = self
        passwordField.delegate = self
//        view.layer.addSublayer(gradient)
//        animate()
        view.addSubview(scrollview)
        
        scrollview.addSubview(UsernameField)
        scrollview.addSubview(imageview)
        scrollview.addSubview((passwordField))
        scrollview.addSubview(registerbutton)
        
        imageview.isUserInteractionEnabled = true
        scrollview.isUserInteractionEnabled = true
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didtapchngeprofilepic))
        
        imageview.addGestureRecognizer(gesture)
        
    }
    @objc private func didtapchngeprofilepic(){
        presentphotoactionsheet()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollview.frame = view.bounds
        let size = scrollview.width/3
        imageview.frame = CGRect(x: (scrollview.width-size)/2,
                                 y: 20,
                                 width: size,
                                 height: size)
        imageview.layer.cornerRadius = imageview.width/2.0
        UsernameField.frame = CGRect(x: 30,
                                  y: imageview.bottom+10,
                                  width: scrollview.width-60,
                                  height: 52)
        
        passwordField.frame = CGRect(x: 30,
                                     y: UsernameField.bottom+10,
                                     width: scrollview.width-60,
                                     height: 52)
        registerbutton.frame = CGRect(x: 30,
                                      y: passwordField.bottom+60,
                                      width: scrollview.width-60,
                                      height: 52)
    }
    @objc private func Register(){
        let spiner = Spinner.init()
        spiner.show()
        guard let image = imageview.image, let Password = passwordField.text, let Username = UsernameField.text else {
            return
        }
        ServerManager.Shared.Register(Username: Username, Password: Password, complection: {result in
            if result{
                UserDefaults.standard.set("AlreadyLoggedIn", forKey: "Status")
                UserDefaults.standard.setValue(self.UsernameField.text!, forKey: "Username")
                UserDefaults.standard.setValue(self.passwordField.text!, forKey: "password")
                UserDefaults.standard.setValue(true, forKey: "IsLoggedIn")
                let storybo : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storybo.instantiateViewController(identifier: "storyboardid")
                self.navigationController?.setNavigationBarHidden(true, animated: false)
                self.navigationController?.isNavigationBarHidden = true
                self.show(vc, sender: nil)
                spiner.hide()
            }
            else{
                let alert = UIAlertController(title: "Alert", message: "Error in creating user, make sure you have Active internet connection, try to change Username, Please Try again later", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        })
    }

}
extension RegisterViewController : UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == UsernameField {
            passwordField.becomeFirstResponder()
        }else if textField == passwordField{
            //Register()
            print("register")
        }
        return true
    }
}
extension RegisterViewController : UIImagePickerControllerDelegate , UINavigationControllerDelegate{
    func presentphotoactionsheet(){
        let actionSheet = UIAlertController(title: "profile picture", message: "How would ypu like to select a picture", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        actionSheet.addAction(UIAlertAction(title: "take photo", style: .default, handler: { [weak self]_ in self?.presentCamera()}))
        actionSheet.addAction(UIAlertAction(title: "Chose photo", style: .default, handler: { [weak self]_ in self?.presentphotopicker() }))
        present(actionSheet,animated: true)
        
    }
    func presentCamera() {
        let vc = UIImagePickerController()
        vc.sourceType = .camera
        vc.delegate = self
        vc.allowsEditing = true
        present(vc,animated:  true)
        
    }
    func presentphotopicker(){
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc,animated: true)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        guard let selectedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else {
            return
        }
        
//        can be change edited imsje

        self.imageview.image = selectedImage
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
