//
//  AppDelegate.swift
//  Chatty(2)
//
//  Created by Amirhossein's macbook pro on 3/23/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
//        UserDefaults.standard.setValue(nil, forKey: "SessionKeys")
//        UserDefaults.standard.setValue(nil, forKey: "LoginToken")
        
        UserDefaults.standard.setValue(false, forKey: "IsConnected")
        print(UserDefaults.standard.value(forKey: "LoginToken"))
        ServerManager.Shared.Connect(complection: {Result in
            if Result {
                print("AlreadyLoggedIn")
                ServerManager.Shared.DisconnectEvent() // handle disconnect event
                UserDefaults.standard.set("AlreadyLoggedIn", forKey: "Status")
                UserDefaults.standard.setValue(true, forKey: "IsConnected")
            }
            else {
                print("NotLoggedIn")
                ServerManager.Shared.DisconnectEvent() // handle dicconnect event
                UserDefaults.standard.set("NotLoggedIn", forKey: "Status")
                UserDefaults.standard.setValue(true, forKey: "IsConnected")
                
            }
        })
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    


}

