//
//  PrivateChatsViewController.swift
//  Chatty(2)
//
//  Created by Amirhossein's macbook pro on 3/23/21.
//

import UIKit

class PrivateChatsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        if (UserDefaults.standard.value(forKey: "IsLoggedIn")) as! Bool == false && (UserDefaults.standard.value(forKey: "Status")) as! String == "NotLoggedIn" {
            let vc = LoginViewController()
            let nav = UINavigationController(rootViewController: vc)
            nav.modalPresentationStyle = .fullScreen
            self.present(nav,animated:  false)
        }
//        if UserDefaults.standard.value(forKey: "IsLoggedIn") == nil {
//            Auth.auth.Checklogin(complection: {result in
//                if result {
//                    UserDefaults.standard.setValue(true, forKey: "IsLoggedIn")
//                    let vc = LoginViewController()
//                    let nav = UINavigationController(rootViewController: vc)
//                    nav.modalPresentationStyle = .fullScreen
//                    self.present(nav,animated:  false)
//                }
//            })
//        }else{
//            if UserDefaults.standard.value(forKey: "IsLoggedIn")! as! Bool == false {
//                Auth.auth.Checklogin(complection: {result in
//                    if result {
//                        UserDefaults.standard.setValue(true, forKey: "IsLoggedIn")
//                        let vc = LoginViewController()
//                        let nav = UINavigationController(rootViewController: vc)
//                        nav.modalPresentationStyle = .fullScreen
//                        self.present(nav,animated:  false)
//                    }
//                })
//            }
//        }
//        
//        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(didTapcomposebutton))
        
    }
    @objc func didTapcomposebutton(){
        
    }
    


}
