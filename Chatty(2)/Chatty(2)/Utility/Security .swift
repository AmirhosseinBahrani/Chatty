//
//  Security .swift
//  Chatty(2)
//
//  Created by Amirhossein's macbook pro on 6/12/21.
//

import Foundation
import UIKit
import CryptoSwift
import RNCryptor
import CommonCrypto

// Key for trasportation : A4J9#m43.Lo;&NGS ,,,, passwordpassword
// Iv for trasportation : P3M8G;*s@sbG{(-a ,,,, drowssapdrowssap
// Key for Saving in keychain : A4J9#m43.Lo;&NGS ,,,, passwordpassword
// Iv for Saving in keychain : P3M8G;*s@sbG{(-a ,,,, drowssapdrowssap

public func Encrypt(Key: String, Iv: String, Data: String) throws -> String {
    do {
        let aes = try AES(key: Key, iv: Iv)
        let ciphertext = try aes.encrypt(Array(Data.utf8))
        return ciphertext.toBase64() ?? ""
    } catch {
        return "Error"
    }
}

public func Decrypt(Key: String, Iv: String, EncryptedData: String) throws -> String {
    do {
        let aes = try AES(key: Key, iv: Iv)
        let ciphertext = try aes.decrypt(Array(EncryptedData.utf8))
        return ciphertext.toBase64() ?? ""
    } catch {
        return "Error"
    }
}

func GenerateToken() -> String {
    let bundleIdentifier = Bundle.main.bundleIdentifier
    let deviceID = UIDevice.current.identifierForVendor!.uuidString
    
    let SecretCode = "4f765e87abd7de8e7bf150ccc84154b07c52e0e5ec6c6165d32ddbe14df17d33" // IfYouDecryptItYouAreSmartButNotAsChattyTeam => md5 => sha256
    
    let PrivateToken = (bundleIdentifier! + deviceID + SecretCode).sha256()

    let EncryptionKey = "fj!lC@d^aGQ%9&a@wuA87n#rw79&"
    
    let EncryptedTokenResult = KeychainServices.Shared.CreateAandUpdate(Key: "LoginToken", Value: PrivateToken, EncryptionKey: EncryptionKey)
    
    
    let EncryptedToken = KeychainServices.Shared.Get(Key: "LoginToken", EncryptionKey: EncryptionKey)
    print(EncryptedToken,"EncryptedToken")
    return EncryptedToken!
}

func GetBI() -> String{
    return try! Encrypt(Key: "A4J9#m43.Lo;&NGSF8K3%l1894Hk^bCp", Iv: "P3M8G;*s@sbG{(-a", Data: Bundle.main.bundleIdentifier!)
}

func GetUD() -> String {
    return try! Encrypt(Key: "A4J9#m43.Lo;&NGSF8K3%l1894Hk^bCp", Iv: "P3M8G;*s@sbG{(-a", Data: UIDevice.current.identifierForVendor!.uuidString)
}
