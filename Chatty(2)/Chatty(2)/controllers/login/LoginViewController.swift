//
//  ViewController.swift
//  Chatty(2)
//
//  Created by Amirhossein's macbook pro on 3/23/21.
//

import UIKit

class LoginViewController: UIViewController {

    private let scrollview : UIScrollView = {
        let scrollview = UIScrollView()
        scrollview.clipsToBounds = true
        scrollview.backgroundColor = UIColor(red: 0.11, green: 0.13, blue: 0.18, alpha: 1.00)
        return scrollview
    }()
    
    private let imageview : UIImageView = {
        let imageview = UIImageView()
        imageview.image = UIImage(named: "chatty")
        imageview.contentMode = .scaleToFill
        imageview.layer.cornerRadius = 25
        imageview.layer.masksToBounds = true
        imageview.layer.borderWidth = 1
        imageview.layer.borderColor = UIColor.black.cgColor
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
        field.keyboardType = .emailAddress
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.placeholder = "Username"
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
        pfield.layer.borderWidth = 0.25
        pfield.layer.borderColor = UIColor.white.cgColor
        // shadow
        pfield.layer.shadowOffset = CGSize.zero // Use any CGSize
        pfield.layer.shadowColor = UIColor.gray.cgColor
        pfield.layer.shadowOpacity = 1
        pfield.layer.shadowRadius = 3.0
        return pfield
    }()
    private let LoginButton : UIButton = {
        let button = UIButton()
        button.setTitle("Log In", for: .normal)
        button.backgroundColor = .link
        button.setTitleColor(.secondarySystemBackground, for: .normal)
        button.layer.cornerRadius = 12
        button.layer.masksToBounds = true
        button.titleLabel?.font = .systemFont(ofSize: 20,weight : .bold)
        return button
    }()
    private let registerbtn: UIButton = {
       let b = UIButton()
        b.setTitle("Register", for: .normal)
        b.backgroundColor = .link
        b.setTitleColor(.secondarySystemBackground, for: .normal)
        b.layer.cornerRadius = 12
        b.layer.masksToBounds = true
        b.titleLabel?.font = .systemFont(ofSize: 14,weight : .bold)
       return b
    }()
    private let loginwithemail : UIButton = {
        let button = UIButton()
        button.setTitle("Log In With Email", for: .normal)
        button.backgroundColor = .link
        button.setTitleColor(.secondarySystemBackground, for: .normal)
        button.layer.cornerRadius = 12
        button.layer.masksToBounds = true
        button.titleLabel?.font = .systemFont(ofSize: 20,weight : .bold)
        return button
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.barTintColor = scrollview.backgroundColor
        self.navigationController?.navigationBar.tintColor = scrollview.backgroundColor
        view.addSubview(scrollview)
        LoginButton.addTarget(self, action: #selector(SignIn), for: .touchUpInside)
        registerbtn.addTarget(self, action: #selector(RegisterBTNTapped), for: .touchUpInside)
        
        scrollview.addSubview(UsernameField)
        scrollview.addSubview(imageview)
        scrollview.addSubview((passwordField))
        scrollview.addSubview(registerbtn)

        scrollview.addSubview(LoginButton)
        // Do any additional setup after loading the view.
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        navigationController?.navigationBar.isHidden = false
        scrollview.frame = view.bounds
        let size = scrollview.width/3
        imageview.frame = CGRect(x: (scrollview.width-size)/2,
                                 y: view.frame.height/7,
                                 width: size,
                                 height: size)
        UsernameField.frame = CGRect(x: 30,
                                  y: imageview.bottom+30,
                                  width: scrollview.width-60,
                                  height: 52)
        passwordField.frame = CGRect(x: 30,
                                     y: UsernameField.bottom+10,
                                     width: scrollview.width-60,
                                     height: 52)
        
        LoginButton.frame = CGRect(x: 30,
                                   y: passwordField.bottom+10,
                                   width: scrollview.width-60,
                                   height: 52)
        registerbtn.frame = CGRect(x: 30, y: LoginButton.bottom+200, width: LoginButton.width, height: 52)
        
        
    }
    
    @objc private func SignIn(){
        let spiner = Spinner.init()
        spiner.show()
        
        ServerManager.Shared.Login(Username: UsernameField.text!, Password: passwordField.text!, complection: {result in
            if result{
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
    
    @objc func RegisterBTNTapped(){
        let vc = RegisterViewController()
        vc.navigationController?.isToolbarHidden = false
        navigationController?.hidesBarsOnSwipe = true
        navigationController?.pushViewController(vc, animated: true)
        
    }
    

}

