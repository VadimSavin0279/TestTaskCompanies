//
//  Model.swift
//  TestTaskCompanies
//
//  Created by 123 on 13.04.2023.
//

import Foundation

struct Card: Codable {
    let company: Company
    let customerMarkParameters: Parameters
    let mobileAppDashboard: Dashboard
    
    struct Company: Codable {
        let companyId: String
    }
    
    struct Parameters: Codable {
        let mark: Int
        let loyaltyLevel: Level
        
        struct Level: Codable {
            let number: Int
            let name: String
            let requiredSum: Int
            let markToCash: Int
            let cashToMark: Int
        }
    }
    
    struct Dashboard: Codable {
        let companyName: String
        let logo: String
        let backgroundColor: String
        let mainColor: String
        let cardBackgroundColor: String
        let textColor: String
        let highlightTextColor: String
        let accentColor: String
    }
}

struct MyError: Codable {
    let message: String
}
