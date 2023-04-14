//
//  CompaniesInteractor.swift
//  TestTaskCompanies
//
//  Created by 123 on 13.04.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol CompaniesBusinessLogic {
    func makeRequest(request: Companies.Model.Request.RequestType)
}

class CompaniesInteractor: CompaniesBusinessLogic {
    
    var presenter: CompaniesPresentationLogic?
    var service: CompaniesService?
    
    func makeRequest(request: Companies.Model.Request.RequestType) {
        if service == nil {
            service = CompaniesService()
        }
        switch request {
        case .some:
            break
        case .getCompanies:
            presenter?.presentData(response: .setLoadingState(true))
            
            service?.fetchCompany(completion: { [self] result in
                presenter?.presentData(response: .presentNewCompanies(result))
                presenter?.presentData(response: .setLoadingState(false))
            }, completionForError: { [self] errorMessage in
                presenter?.presentData(response: .showAlert(errorMessage))
                presenter?.presentData(response: .stopRequests)
            })
        case .getCompanyInfo(let model, let type):
            presenter?.presentData(response: .processInfo(model.company.companyId, type))
        }
    }
    
}
