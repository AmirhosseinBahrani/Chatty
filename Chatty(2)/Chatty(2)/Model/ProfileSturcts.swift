//
//  ProfileSturcts.swift
//  Chatty(2)
//
//  Created by Amirhossein's macbook pro on 3/28/21.
//

import Foundation
import UIKit

public struct Sections{
    let title: String
    let options: [ProfileOptions]
}

public struct ProfileOptions{
    let Title: String
    let Icon : UIImage?
    let IconBGColor: UIColor
    let handler : (() -> Void)
}

