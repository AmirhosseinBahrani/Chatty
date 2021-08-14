//
//  extensions.swift
//  Chatty(2)
//
//  Created by Amirhossein's macbook pro on 3/23/21.
//

import Foundation
import UIKit

extension UIView{
    public var width : CGFloat{
        return self.frame.size.width
    }
    public var height : CGFloat{
        return self.frame.size.height
    }
    public var top : CGFloat{
        return self.frame.origin.y
    }
    public var bottom : CGFloat{
        return self.frame.size.height + self.frame.origin.y
    }
    public var left : CGFloat{
        return self.frame.origin.x
    }
    public var right : CGFloat{
        return self.frame.size.width + self.frame.origin.x
    }
}

extension UIViewController {
    func hidekeyboardwhenpressedout(){
        let tapgesturereco = UITapGestureRecognizer(target: self, action: #selector(hidekeyboard))
        view.addGestureRecognizer(tapgesturereco)
    }
    
    @objc func hidekeyboard(){
        view.endEditing(true)
    }
    
//    Mark :
    public func showalert(message:String){
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
    }
}



extension Notification.Name {
    static let didloginnotification = Notification.Name("didloginnotification")
}


extension UIView {
    
    /** Adds Constraints in Visual Formate Language. It is a helper method defined in extensions for convinience usage
     
     - Parameter format: string formate as we give in visual formate, but view placeholders are like v0,v1, etc
     - Parameter views: It is a variadic Parameter, so pass the sub-views with "," seperated.
     */
    func addConstraintsWithVisualStrings(format: String, views: UIView...) {
        
        var viewsDictionary = [String: UIView]()
        
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            view.translatesAutoresizingMaskIntoConstraints = false
            viewsDictionary[key] = view
        }
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: viewsDictionary))
    }
    
    /** This method binds the view with frame of keyboard frame. So, The View will change its frame with the height of the keyboard's height */
    func bindToTheKeyboard(_ bottomConstaint: NSLayoutConstraint? = nil) {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(_:)), name: UIResponder.keyboardWillChangeFrameNotification, object: bottomConstaint)
    }
    
    @objc func keyboardWillChange(_ notification: NSNotification) {
        
        let duration = notification.userInfo![UIResponder.keyboardAnimationDurationUserInfoKey] as! Double
        let curve = notification.userInfo![UIResponder.keyboardAnimationCurveUserInfoKey] as! UInt
        let curveframe = (notification.userInfo![UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        let targetFrame = (notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        
        let deltaY = targetFrame.origin.y - curveframe.origin.y
        
        if let constraint = notification.object as? NSLayoutConstraint {
            constraint.constant = deltaY
            UIView.animateKeyframes(withDuration: duration, delay: 0.0, options: UIView.KeyframeAnimationOptions.init(rawValue: curve), animations: {
                self.layoutIfNeeded()
            }, completion: nil)
            
        } else {
            UIView.animateKeyframes(withDuration: duration, delay: 0.0, options: UIView.KeyframeAnimationOptions.init(rawValue: curve), animations: {
                self.frame.origin.y += deltaY
            }, completion: nil)
        }
    }
}

extension UIView {
    
    func addconstraintsWwthvisualstrings(format: String, views: UIView...) {
        
        var viewsDictionary = [String: UIView]()
        
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            view.translatesAutoresizingMaskIntoConstraints = false
            viewsDictionary[key] = view
        }
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: viewsDictionary))
    }
    
    /** This method binds the view with frame of keyboard frame. So, The View will change its frame with the height of the keyboard's height */
    func bindtokeyboard(_ bottomConstaint: NSLayoutConstraint? = nil) {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(_:)), name: UIResponder.keyboardWillChangeFrameNotification, object: bottomConstaint)
    }
    
    @objc func keyboardwillchange(_ notification: NSNotification) {
        
        let duration = notification.userInfo![UIResponder.keyboardAnimationDurationUserInfoKey] as! Double
        let curve = notification.userInfo![UIResponder.keyboardAnimationCurveUserInfoKey] as! UInt
        let curveframe = (notification.userInfo![UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        let targetFrame = (notification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        
        let deltaY = targetFrame.origin.y - curveframe.origin.y
        
        if let constraint = notification.object as? NSLayoutConstraint {
            constraint.constant = deltaY
            UIView.animateKeyframes(withDuration: duration, delay: 0.0, options: UIView.KeyframeAnimationOptions.init(rawValue: curve), animations: {
                self.layoutIfNeeded()
            }, completion: nil)
            
        } else {
            UIView.animateKeyframes(withDuration: duration, delay: 0.0, options: UIView.KeyframeAnimationOptions.init(rawValue: curve), animations: {
                self.frame.origin.y += deltaY
            }, completion: nil)
        }
    }
}
extension Date {
   func getFormattedDate(format: String) -> String {
        let dateformat = DateFormatter()
        dateformat.dateFormat = format
        return dateformat.string(from: self)
    }
}


extension UIImageView {
    var contentClippingRect: CGRect {
        guard let image = image else { return bounds }
        guard contentMode == .scaleAspectFit else { return bounds }
        guard image.size.width > 0 && image.size.height > 0 else { return bounds }

        let scale: CGFloat
        if image.size.width > image.size.height {
            scale = bounds.width / image.size.width
        } else {
            scale = bounds.height / image.size.height
        }

        let size = CGSize(width: image.size.width * scale, height: image.size.height * scale)
        let x = (bounds.width - size.width) / 2.0
        let y = (bounds.height - size.height) / 2.0

        return CGRect(x: x, y: y, width: size.width, height: size.height)
    }
}
