//
//  Extension.swift
//  VITOR
//
//  Created by APPLE on 5/16/20.
//  Copyright © 2020 BinaryCode. All rights reserved.
//

import Foundation
import UIKit
//import MaterialComponents.MaterialActivityIndicator
//import Toast_Swift
import JTProgressHUD

extension UIView {
    
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        if #available(iOS 11.0, *) {
            clipsToBounds = true
            layer.cornerRadius = radius
            layer.maskedCorners = CACornerMask(rawValue: corners.rawValue)
        } else {
            let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
            let mask = CAShapeLayer()
            mask.path = path.cgPath
            layer.mask = mask
        }
    }
}

extension UIViewController{
    
//    func saveUserData(loginModel:LoginModel) {
//        UserDefaults.standard.set(loginModel.toDictionary(), forKey: "UserData")
//        UserDefaults.standard.synchronize()
//    }
//    
//    func getUserData() -> LoginDataModel {
//        var loginDataModel = LoginDataModel()
//        
//        if let data = UserDefaults.standard.object(forKey: "UserData"){
//            loginDataModel = LoginModel(dictionary: data as! NSDictionary).data
//        }
//        
//        return loginDataModel
//    }
    
    var isPresented : Bool {
        
        let presentingIsModal = presentingViewController != nil
        let presentingIsNavigation = navigationController?.presentingViewController?.presentedViewController == navigationController
        let presentingIsTabBar = tabBarController?.presentingViewController is UITabBarController
        
        return presentingIsModal || presentingIsNavigation || presentingIsTabBar
    }
    
    
    func ShowHUD() {
        DispatchQueue.main.async {
//            SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.black)
            JTProgressHUD.show()
        }
        
//        let actInd = MDCActivityIndicator(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height))
//        actInd.tag = 999
//        actInd.backgroundColor = UIColor.black.withAlphaComponent(0.4)
//        actInd.indicatorMode = .indeterminate
//        if let Window = UIApplication.shared.windows.filter({$0.isKeyWindow}).first {
//            Window.addSubview(actInd)
//            Window.bringSubviewToFront(actInd)
//        }
//        actInd.radius = 20
//        actInd.strokeWidth = 4
//        actInd.center = self.view.center
//        actInd.cycleColors = [UIColor(named: "theme_color")!]
//        actInd.startAnimating()
    }
    
    func HideHUD() {
        DispatchQueue.main.async {
            JTProgressHUD.hide()
        }
//        if let Window = UIApplication.shared.windows.filter({$0.isKeyWindow}).first {
//            for actView in Window.subviews where actView.tag == 999 {
//                if let actInd = actView as? MDCActivityIndicator {
//                    actInd.stopAnimating()
//                    actInd.removeFromSuperview()
//                }
//            }
//        }
    }
    
//    func showAlertToast(str:String){
//        if let Window = UIApplication.shared.windows.filter({$0.isKeyWindow}).first {
//            Window.makeToast(str)
//        }
//    }
    
    
    func isUserLoggedIn() -> Bool{
        if LoginDataModel.currentUser?.access_token.count != 0 && LoginDataModel.currentUser?.access_token != nil{
            return true
        }
        return false
    }
    
}


extension UIViewController {
    
    class var storyBoardID : String {
        return "\(self)"
    }
    
//    func instantiateDashboardNav() -> NavigationClass {
//        return main.instantiateViewController(withClass: NavigationClass.self)!
//    }
    
    var main : UIStoryboard {
        return UIStoryboard(name: "Main", bundle: nil)
    }
    
//    func instantiateSideMenu() -> SideMenu {
//        return main.instantiateViewController(withClass: SideMenu.self)!
//    }
    
}

extension NSNotification.Name {
    static let ClickedSideMenu = NSNotification.Name.init("ClickedSideMenu")
}

extension NSMutableAttributedString {
    
    var fontSize:CGFloat { return 14 }
    
    var boldFont:UIFont { return UIFont.boldSystemFont(ofSize: fontSize) }
    
    var normalFont:UIFont { return UIFont.systemFont(ofSize: fontSize)}
    
    func bold(_ value:String) -> NSMutableAttributedString {
        
        let attributes:[NSAttributedString.Key : Any] = [
            .font : boldFont
        ]
        
        self.append(NSAttributedString(string: value, attributes:attributes))
        return self
    }
    
    func normal(_ value:String) -> NSMutableAttributedString {
        
        let attributes:[NSAttributedString.Key : Any] = [
            .font : normalFont,
        ]
        
        self.append(NSAttributedString(string: value, attributes:attributes))
        return self
    }
    
    /* Other styling methods */
    func highlight(_ value:String, foregroundColor : UIColor, backgroundColor : UIColor) -> NSMutableAttributedString {
        
        let attributes:[NSAttributedString.Key : Any] = [
            .font :  normalFont,
            .foregroundColor : foregroundColor,
            .backgroundColor : backgroundColor
        ]
        
        self.append(NSAttributedString(string: value, attributes:attributes))
        return self
    }
    
    func underlined(_ value:String) -> NSMutableAttributedString {
        
        let attributes:[NSAttributedString.Key : Any] = [
            .font :  normalFont,
            .underlineStyle : NSUnderlineStyle.single.rawValue
            
        ]
        
        self.append(NSAttributedString(string: value, attributes:attributes))
        return self
    }
    
}


extension UITextField {
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}

extension String {
    func caseInsensitiveHasPrefix(_ prefix: String) -> Bool {
        return lowercased().hasPrefix(prefix.lowercased())
    }
}
