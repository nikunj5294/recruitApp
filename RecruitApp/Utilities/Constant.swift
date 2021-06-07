//
//  Constant.swift
//  RecruitApp
//
//  Created by MAC on 03/02/21.
//

import Foundation
import UIKit

struct ConstantsString {
    static let ApplicationName = "RecruitApp"
}

struct ValidationMessage {
    static let EnterEmail = "Please enter email"
    static let EnterValidEmail = "Please enter valid email"
    static let EnterPassword = "Please enter password"
    static let EnterFirstName = "Please enter first name"
    static let EnterLastName = "Please enter last name"
    static let EnterMobileNumber = "Please enter mobile number"
    static let EnterValidPassword = "Password must contain at least 8 characters"
    static let EnterConfirmPassword = "Please enter confirm password"
    static let EnterCurrentPassword = "Please enter current password"
    static let EnterNewPassword = "Please enter new password"
    static let EnterPasswordDoNotMatch = "Passwords entered do not match"
    
    static let EnterJobTitle = "Please enter job title"
    static let SelectLocation = "Please select location"
    static let SelectCatrgory = "Please select category"
    static let SelectSkill = "Please select skill"
    static let SelectDesiredLevel = "Please select desired experience level"
    static let SelectYearsExperienceLevel = "Please select years experience"
}


let APPDELEGATE = UIApplication.shared.delegate as! AppDelegate
let strAppName = "Recruit App"
let strOk = "OK"
var Access_token = ""
var dashboardDetailsdata = EmployerDashboardDataModel()
//var userType = "employer"
//var loginModelData = LoginModel()
var IsUserCustomer = true
var DeviceToken = "123456789"
var isAlertOpen = false
var BidSlugName = ""
var per_page_data = 10

var skipWelcomeScreen : Bool {
    get {
        return UserDefaults.standard.bool(forKey: "skipWelcomeScreen")
    }
    set {
        UserDefaults.standard.set(newValue, forKey: "skipWelcomeScreen")
    }
}

var isRememberPassword : Bool {
    get {
        return UserDefaults.standard.bool(forKey: "isRememberPassword")
    }
    set {
        UserDefaults.standard.set(newValue, forKey: "isRememberPassword")
    }
}

enum UserType : String {
    case seeker = "seeker"
    case employer = "employer"
}

enum SideMenuTitle : String {
    case Home = "Home"
    case Message = "Message"
    case Bookmarks = "Bookmarks"
    case Settings = "Settings"
    case Jobs = "Jobs"
    case FAQ = "FAQ"
    case ContactUs = "Contact Us"
    case Signout = "Sign out"
    case Profile = "Profile"
    case Tasks = "Tasks"
    case Reviews = "Reviews"
    case MyWallet = "My Wallet"
    
}

var userType : UserType {
    get {
        if let userTypeValue = UserDefaults.standard.value(forKey: "UserType") as? String {
            return UserType(rawValue: userTypeValue)!
        }
        return UserType.seeker
    }
    set {
        UserDefaults.standard.setValue(newValue.rawValue, forKey: "UserType")
        UserDefaults.standard.synchronize()
    }
}


struct Theme {
    static var colors = Colors()
}

struct Colors {
    let background_color_light = UIColor(named: "background_color_light")
    let blue_title_color = UIColor(named: "blue_title_color")
    let border_color = UIColor(named: "border_color")
    let button_bg = UIColor(named: "button_bg")
    let button_selection = UIColor(named: "button_selection")
    let chat_bottom_color = UIColor(named: "chat_bottom_color")
    let chat_header_color = UIColor(named: "chat_header_color")
    let font_color = UIColor(named: "font_color")
    let font_title_color = UIColor(named: "font_title_color")
    let orange_color_light = UIColor(named: "orange_color_light")
    let orange_color = UIColor(named: "orange_color")
    let peach_color_light = UIColor(named: "peach_color_light")
    let peach_color = UIColor(named: "peach_color")
    let price_slider_color = UIColor(named: "price_slider_color")
    let purple_color_light = UIColor(named: "purple_color_light")
    let purple_color_with_opacity = UIColor(named: "purple_color_with_opacity")
    let purple_color = UIColor(named: "purple_color")
    let sky_blue_color = UIColor(named: "sky_blue_color")
    let tag_back_color_fp = UIColor(named: "tag_back_color_fp")
    let textfield_bg = UIColor(named: "textfield_bg")
    let theme_color = UIColor(named: "theme_color")
    let violet_color_light = UIColor(named: "violet_color_light")
    let violet_color = UIColor(named: "violet_color")
    
    
    let themeColor = UIColor(named: "theme_color")
    let borderColor = UIColor(named: "border_color")
    let buttonBg = UIColor(named: "Primary_Color")
    let buttonBgSelection = UIColor(named: "Segmented_button")
    let fontColor = UIColor(named: "font_color")
    let fontTitleColor = UIColor(named: "font_title_color")
    let orangeColor = UIColor(named: "orange_color")
    let notificationBackgroundColor = UIColor(red: 235, green: 248, blue: 243)
}

extension UIViewController {
    
    func setDashboardData(respData:EmployerDashboardDataModel) {
        UserDefaults.standard.setValue(respData.toDictionary(), forKey: "DashboardData")
        UserDefaults.standard.synchronize()
    }
    
    func getDashboardData() -> EmployerDashboardDataModel {
        
        if let data = UserDefaults.standard.object(forKey: "DashboardData"){
            return EmployerDashboardDataModel(dictionary: data as! NSDictionary)
        }
        
        return EmployerDashboardDataModel()
    }
    
}
