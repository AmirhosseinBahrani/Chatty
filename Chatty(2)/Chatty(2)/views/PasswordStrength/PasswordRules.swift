//
//  PasswordRules.swift
//  Chatty(2)
//
//  Created by Amirhossein's macbook pro on 3/28/21.
//

import Foundation

public class PasswordRules {
    public static var passwordRule : [ValidationRequiredRule] = [.lowerCase , .digit, .oneUniqueCharacter, .minmumLength]
    
    public static var weakStrengthColor : String = "F44336"
    public static var mediumStrengthColor : String = "FFC108"
    public static var strongStrengthColor : String = "04A9F3"
    public static var veryStrongStrengthColor : String = "8BC34A"
    
    public static var isUniqueCharRequired: Bool =  true
    public static var minPasswordLength : Int = 6
    public static var maxPasswordLength : Int = 20
}
