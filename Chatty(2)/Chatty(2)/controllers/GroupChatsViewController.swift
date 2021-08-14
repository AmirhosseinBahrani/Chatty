//
//  GroupChatsViewController.swift
//  Chatty(2)
//
//  Created by Amirhossein's macbook pro on 3/23/21.
//

import UIKit

class GroupChatsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.topItem?.title = "Connecting"
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
        
        
        navigationController?.navigationBar.topItem?.title = "Groups"
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
