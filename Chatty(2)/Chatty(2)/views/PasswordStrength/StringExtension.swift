//
//  StringExtension.swift
//  Chatty(2)
//
//  Created by Amirhossein's macbook pro on 3/28/21.
//

import Foundation

extension String {
    /**
     true if self contains characters.
     */
    public var isNotEmpty: Bool {
        return !isEmpty
    }
    
    
    func satisfiesRegexp(_ regexp: String) -> Bool {
        return range(of: regexp, options: .regularExpression) != nil
    }
}
