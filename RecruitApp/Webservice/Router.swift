//
//  Router.swift
//  HelprData
//
//  Created by Kim Metso on 2015-09-23.
//  Copyright © 2015 Helpr. All rights reserved.
//

import Foundation
import Alamofire
import SwifterSwift

enum Router: URLRequestConvertible {
    
    static let baseURLString = UIApplication.shared.inferredEnvironment == .appStore ? "https://admin.recruit.nz/api/" : "https://admin.recruit.nz/api/"
    static var authToken = ""
    static var isForceUpdateOpen = false
    
    public func asURLRequest() throws -> URLRequest {
        let route = self.route
        let url = URL(string: Router.baseURLString)!
        var mutableURLRequest = URLRequest(url: url.appendingPathComponent(route.path))
        mutableURLRequest.httpMethod = route.method.rawValue
        
        if let token = LoginDataModel.currentUser?.access_token {
            mutableURLRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        
        mutableURLRequest.setValue("application/json", forHTTPHeaderField: "Accept")
        
        print("router data", route.data ?? "")
        print("API path", mutableURLRequest.url!)
        
        if let data = route.data {
            if route.method == .get {
                return try Alamofire.URLEncoding.default.encode(mutableURLRequest, with: data)
            }
            return try Alamofire.JSONEncoding.default.encode(mutableURLRequest, with: data)
        }
        return mutableURLRequest
    }
    
    case login([String:String])
    case logout
    case register([String:String])
    case forgotPassword([String:String])
    case seekerEmployerDashboard
    case EmployerJobList
    case EmployerJobDraftList([String:String])
    case EmployerJobExpiredList([String:String])
    case EmployerTransactionList([String:String])
    case EmployerCandidateList([String:String])
    case ChangePassword([String:String])
    case locations
    case categoriesMain
    case skills
    case packages
    case jobCreate([String:String])
    case jobUpdate([String:Any])
    case employerProfile
    case stateList
    case teamList([String:String])
    case createTeam([String:String])
    case updateTeam([String:String])
    case deleteTeam([String:String])
    case contactUS([String:String])
    case AppliedJobList([String:String])
    case SearchJobList([String:String])
    case JobDetails([String:String])
    
    var route: Route {
        switch self {
        case .login(let data):
            return Route(path: "\(userType)/login", method: .post, data: data)
        case .logout:
            return Route(path: "\(userType)/logout", method: .get)
        case .register(let data):
            return Route(path: "\(userType)/register", method: .post, data: data)
        case .forgotPassword(let data):
            return Route(path: "password/create", method: .post, data: data)
        case .seekerEmployerDashboard:
            return Route(path: "\(userType)/user/dashboard", method: .post)
        case .EmployerJobList:
            return Route(path: "\(userType)/job", method: .post)
        case .EmployerJobDraftList(let data):
            return Route(path: "\(userType)/job/draft", method: .post, data: data)
        case .EmployerJobExpiredList(let data):
            return Route(path: "\(userType)/job/expired", method: .post, data: data)
        case .EmployerTransactionList(let data):
            return Route(path: "\(userType)/transactions", method: .post, data: data)
        case .EmployerCandidateList(let data):
            return Route(path: "\(userType)/candidate", method: .post, data: data)
        case .ChangePassword(let data):
            return Route(path: "\(userType)/user/password/change", method: .post, data: data)
        case .locations:
            return Route(path: "locations", method: .post)
        case .categoriesMain:
            return Route(path: "categories/main", method: .post)
        case .skills:
            return Route(path: "skills", method: .post)
        case .packages:
            return Route(path: "\(userType)/packages", method: .post)
        case .jobCreate(let data):
            return Route(path: "\(userType)/job/create", method: .post, data: data)
        case .jobUpdate(let data):
            return Route(path: "\(userType)/job/update", method: .post, data: data)
        case .employerProfile:
            return Route(path: "\(userType)/user", method: .get)
        case .stateList:
            return Route(path: "locations/state", method: .post)
        case .teamList(let data):
            return Route(path: "\(userType)/team", method: .post, data: data)
        case .createTeam(let data):
            return Route(path: "\(userType)/team/create", method: .post, data: data)
        case .updateTeam(let data):
            return Route(path: "\(userType)/team/update", method: .post, data: data)
        case .deleteTeam(let data):
            return Route(path: "\(userType)/team/delete", method: .post, data: data)
        case .contactUS(let data):
            return Route(path: "contact_us/send", method: .post, data: data)
        case .AppliedJobList(let data):
            return Route(path: "\(userType)/job", method: .post, data: data)
        case .SearchJobList(let data):
            return Route(path: "jobs/search", method: .post, data: data)
        case .JobDetails(let data):
            return Route(path: "jobs/view/\(data["slug"] ?? "")", method: .post, data: data)
        }
    }
    
}

