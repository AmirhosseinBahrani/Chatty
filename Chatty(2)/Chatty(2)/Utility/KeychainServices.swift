//
//  KeychainServices.swift
//  Chatty(2)
//
//  Created by Amirhossein's macbook pro on 6/22/21.
//

import Foundation
import UIKit
import Security
import SwiftKeychainWrapper
import RNCryptor
// Key for Generating FirstToken : Af3J5!n$c"sk%M65

internal class KeychainServices: NSObject {
    
    static let Shared = KeychainServices()
    
    func Remove(Key: String, EncryptionKey: String) -> Bool {
        let EncryptedKey = try! Encrypt(Key: "A4J9#m43.Lo;&NGSF8K3%l1894Hk^bCp", Iv: "P3M8G;*s@sbG{(-a", Data: Key)
        return KeychainWrapper.standard.removeObject(forKey: EncryptedKey)
    }
    func Get(Key: String, EncryptionKey: String) -> String? {
        
        let EncryptedKey = try! Encrypt(Key: "A4J9#m43.Lo;&NGSF8K3%l1894Hk^bCp", Iv: "P3M8G;*s@sbG{(-a", Data: Key)
        
        guard let Data = KeychainWrapper.standard.string(forKey: EncryptedKey) else {
            return nil
        }
        return Data
    }
    func CreateAandUpdate(Key: String, Value: String, EncryptionKey: String) -> Bool? {
        let EncryptedKey = try! Encrypt(Key: "A4J9#m43.Lo;&NGSF8K3%l1894Hk^bCp", Iv: "P3M8G;*s@sbG{(-a", Data: Key)
        let EncryptedValue = try! Encrypt(Key: "A4J9#m43.Lo;&NGSF8K3%l1894Hk^bCp", Iv: "P3M8G;*s@sbG{(-a", Data: Value)
        guard let data = KeychainWrapper.standard.string(forKey: Key) else {
            return KeychainWrapper.standard.set(EncryptedValue, forKey: EncryptedKey)
        }
        if KeychainWrapper.standard.removeObject(forKey: EncryptedKey){
            return KeychainWrapper.standard.set(EncryptedValue, forKey: EncryptedKey)
        }
        else{
            return nil
        }
    }
}
