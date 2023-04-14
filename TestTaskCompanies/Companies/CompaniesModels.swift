//
//  CompaniesModels.swift
//  TestTaskCompanies
//
//  Created by 123 on 13.04.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

enum Companies {
    enum Model {
        struct Request {
            enum RequestType {
                case some
                case getCompanies
                case getCompanyInfo(Card, MyButtonType)
            }
        }
        struct Response {
            enum ResponseType {
                case some
                case presentNewCompanies([Card])
                case showAlert(String)
                case setLoadingState(Bool)
                case processInfo(String, MyButtonType)
                case stopRequests
            }
        }
        struct ViewModel {
            enum ViewModelData {
                case some
                case displayNewCompanies([Card])
                case showAlert(String)
                case displayLoader(Bool)
                case showAllertWithInfo(String, String)
                case stopRequests
            }
        }
    }
}

struct CompaniesModel {
    var companies: [Card] = []
}
