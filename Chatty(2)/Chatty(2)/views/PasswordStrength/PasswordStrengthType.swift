//
//  PasswordStrengthType.swift
//  Chatty(2)
//
//  Created by Amirhossein's macbook pro on 3/28/21.
//

import Foundation

enum StrengthType {
    case weak
    case medium
    case strong
    case veryStrong
}

public enum ValidationRequiredRule {
    case lowerCase
    case uppercase
    case digit
    case specialCharacter
    case oneUniqueCharacter
    case minmumLength
}
