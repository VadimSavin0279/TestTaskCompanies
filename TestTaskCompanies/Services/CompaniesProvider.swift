//
//  MenuProvider.swift
//  TaskTestFood
//
//  Created by 123 on 03.04.2023.
//

import Foundation
import Alamofire

protocol Provider {
    var baseURL: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: HTTPHeaders { get }
    var params: Parameters { get }
}

enum CompaniesProvider: Provider {
    case getAllCompanies
    case getAllCompaniesIdeal
    case getAllCompaniesLong
    case getAllCompaniesError
}

extension CompaniesProvider {
    
    var baseURL: String {
        return "http://dev.bonusmoney.pro/mobileapp"
    }
    
    var path: String {
        switch self {
        case .getAllCompanies:
            return "/getAllCompanies"
        case .getAllCompaniesIdeal:
            return "/getAllCompaniesIdeal"
        case .getAllCompaniesLong:
            return "/getAllCompaniesLong"
        case .getAllCompaniesError:
            return "/getAllCompaniesError"
        }
    }
    
    var method: HTTPMethod {
        return .post
    }
    
    var headers: HTTPHeaders {
        return HTTPHeaders(["TOKEN": "123"])
    }
    
    var params: Parameters {
        return ["offset": "0"]
    }
}
