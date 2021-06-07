//
//  Route.swift
//  HelprData
//
//  Created by Kim Metso on 2015-09-23.
//  Copyright © 2015 Helpr. All rights reserved.
//

import Foundation
import Alamofire

class Route {
    let path: String
    let method: Alamofire.HTTPMethod
    let data: [String: Any]?
    
    init(path: String, method: Alamofire.HTTPMethod, data: [String: Any]) {
        self.path = path
        self.method = method
        self.data = data
    }
    
    init(path: String, method: Alamofire.HTTPMethod) {
        self.path = path
        self.method = method
        self.data = nil
    }
    
    var encoding: Alamofire.ParameterEncoding {
        switch method {
        case .post, .put, .patch, .delete:
            return JSONEncoding()
        default:
            return URLEncoding()
        }
    }
}
