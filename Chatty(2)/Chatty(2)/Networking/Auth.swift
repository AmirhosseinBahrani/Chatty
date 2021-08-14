//
//  Auth.swift
//  Chatty(2)
//
//  Created by Amirhossein's macbook pro on 3/23/21.
//

import Foundation
import Alamofire
import UIKit
import SocketIO
import CryptoSwift

class ServerManager: NSObject {
    
    static let Shared = ServerManager()
    
    static let Token = GenerateToken()
    
    // Token = (Bundle.main.bundleIdentifier! + UIDevice.current.identifierForVendor!.uuidString + "4f765e87abd7de8e7bf150ccc84154b07c52e0e5ec6c6165d32ddbe14df17d33").sha256()
    private override init() {
        super.init()
        self.Socket = Manager.defaultSocket
    }
    
    var Socket: SocketIOClient!
    
    var Manager = SocketManager(socketURL: URL(string: "http://178.63.176.114:80")!, config: [.log(false), .compress, .connectParams(["Token" : try! Encrypt(Key: "A4J9#m43.Lo;&NGSF8K3%l1894Hk^bCp", Iv: "P3M8G;*s@sbG{(-a", Data: Token),
"BI" : try! Encrypt(Key: "A4J9#m43.Lo;&NGSF8K3%l1894Hk^bCp", Iv: "P3M8G;*s@sbG{(-a", Data: Bundle.main.bundleIdentifier!),
"UD" : try! Encrypt(Key: "A4J9#m43.Lo;&NGSF8K3%l1894Hk^bCp", Iv: "P3M8G;*s@sbG{(-a", Data: UIDevice.current.identifierForVendor!.uuidString),
"LT" : UserDefaults.standard.value(forKey: "LoginToken") ?? "NotCreated",
"Keys" : "\((UserDefaults.standard.value(forKey: "SessionKeys") as? Array<String>) )"]),
.reconnects(true),
.reconnectWait(2),
.reconnectAttempts(3000),
.reconnectWaitMax(10000)
    ])
    
    func Connect(complection: @escaping (Bool) -> Void) {
        Socket.connect(timeoutAfter: 0, withHandler: nil)
        
        Socket.on(clientEvent: .connect, callback: {data, ack in
            self.Socket.on("Status", callback: {d,a in
                if d[0] as? String == "AlreadyLoggedIn"{
                    complection(true)
                }
                else{
                    complection(false)
                }
            })
        })
        
    }
    
    func DisconnectEvent() {
        Socket.on(clientEvent: .disconnect, callback: {data, ack in
            UserDefaults.standard.setValue(false, forKey: "IsConnected")
            // when user disconencted show him a message
        })
    }
    
    func ReconnectEvent() {
        Socket.on(clientEvent: .reconnect, callback: {data, ack in
            UserDefaults.standard.setValue(false, forKey: "IsConnected")
        })
    }
    
    func Register(Username : String , Password: String, complection: @escaping(Bool) -> Void) {
        Socket.emitWithAck("Register", Username,Password).timingOut(after: 3, callback: {data in
            let result = data[0]
            print(result)
            let ModefiedData = result as? [String: String]
            
            print(data,"data")
            if ModefiedData!["Status"] as! String == "Succefull"{
                
                UserDefaults.standard.setValue(self.GenerateLoginToken(Username: Username, Password: Password), forKey: "LoginToken")
                UserDefaults.standard.setValue([ModefiedData!["SessionKey1"], ModefiedData!["SessionIv1"], ModefiedData!["SessionKey2"], ModefiedData!["SessionIv2"]], forKey: "SessionKeys")
                UserDefaults.standard.setValue(true, forKey: "IsLoggedIn")
                UserDefaults.standard.setValue("AlreadyLoggedIn", forKey: "StatusBeforeServerChecks")
                complection(true)

            }
            else{
                complection(false)
            }
            
        })
    }
    func Login(Username : String , Password: String, complection: @escaping(Bool) -> Void) {
        Socket.emitWithAck("Login", Username,Password).timingOut(after: 30, callback: {data in
            let result = data[0]
            print(result)
            let ModefiedData = result as? [String: String]
            
            print(data,"data")
            if ModefiedData!["Status"] as! String == "Succefull"{
                
                UserDefaults.standard.setValue(self.GenerateLoginToken(Username: Username, Password: Password), forKey: "LoginToken")
                UserDefaults.standard.setValue([ModefiedData!["SessionKey1"], ModefiedData!["SessionIv1"], ModefiedData!["SessionKey2"], ModefiedData!["SessionIv2"]], forKey: "SessionKeys")
                UserDefaults.standard.setValue(true, forKey: "IsLoggedIn")
                UserDefaults.standard.setValue("AlreadyLoggedIn", forKey: "StatusBeforeServerChecks")
                complection(true)

            }
            else{
                complection(false)
            }
        })
    }
    
    func GenerateLoginToken(Username: String?, Password: String?) -> String {
        if Username == nil{
            return "NotCreated"
        }
        return (Username! + ((Password!).md5() + (Username! + Password!).md5()).sha512()).md5()
    }
    
    func Logout(com: @escaping(Bool) -> Void) {
        Socket.emitWithAck("Logout").timingOut(after: 30, callback: {data in
            let result = data[0]
            let ModefiedData = result as? [String: String]
            print(ModefiedData)
            if ModefiedData!["Status"] == "Succefull"{
                UserDefaults.standard.setValue(false, forKey: "IsLoggedIn")
                UserDefaults.standard.setValue(nil, forKey: "LoginToken")
                UserDefaults.standard.setValue(nil, forKey: "SessionKeys")
                UserDefaults.standard.setValue("NotLoggedIn", forKey: "Status")
                // before you
                com(true)
            }
            
        })
        
    }
    
}


