//
//  StorageManager.swift
//  Chatty(2)
//
//  Created by Amirhossein's macbook pro on 3/28/21.
//

import Foundation
import Alamofire
import UIKit

class StorageManager {
    static let shared = StorageManager()
}

extension StorageManager{
    public func DownloadFiles(username:String , complection : @escaping(Result<Data, Error>) -> Void){
        let parameters = ["username":username]
        Alamofire.AF.request("http://178.63.176.114:80/Auth/GetImage", method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .responseData{ response in
                switch response.result{
                case .success(let result):
                    complection(.success(result))
                case .failure(let err):
                    complection(.failure(err))
                }
            }
        
    }
}
