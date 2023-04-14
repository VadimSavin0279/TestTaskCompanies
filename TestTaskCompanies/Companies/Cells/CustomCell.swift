//
//  CustomCell.swift
//  TestTaskCompanies
//
//  Created by 123 on 13.04.2023.
//

import UIKit
import SDWebImage

enum MyButtonType: Int {
    case delete = 0
    case view = 1
    case more = 2
}

class CustomCell: UITableViewCell {

    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var mainViewForCell: UIView!
    @IBOutlet weak var companyNameLabel: UILabel!
    @IBOutlet weak var scoreCountLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var cashbackLabel: UILabel!
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var cashbackCounLabel: UILabel!
    @IBOutlet weak var levelNameLabel: UILabel!
    @IBOutlet weak var viewButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var moreButton: UIButton!
    
    var model: Card?
    
    weak var viewController: ViewController?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        renderCell()
    }
    
    override func layoutSubviews() {
        logoImageView.layer.cornerRadius = logoImageView.bounds.height / 2
    }
    
    private func renderCell() {
        mainViewForCell.layer.cornerRadius = 30
        mainViewForCell.clipsToBounds = true
        
        moreButton.layer.cornerRadius = 12
        moreButton.clipsToBounds = true
        backgroundColor = .clear
    }
    
    func configureCell(with model: Card, of viewController: ViewController) {
        setColorForCardInAccordance(with: model)
        setInfoForCardInAccordance(with: model)
        self.model = model
        self.viewController = viewController
    }
    
    private func setInfoForCardInAccordance(with model: Card) {
        companyNameLabel.text = model.mobileAppDashboard.companyName
        scoreCountLabel.text = String(model.customerMarkParameters.mark)
        levelNameLabel.text = model.customerMarkParameters.loyaltyLevel.name
        cashbackCounLabel.text = String(model.customerMarkParameters.loyaltyLevel.cashToMark) + "%"
        if let url = URL(string: model.mobileAppDashboard.logo) {
            logoImageView.sd_setImage(with: url)
        }
    }
    
    private func setColorForCardInAccordance(with model: Card) {
        mainViewForCell.backgroundColor = UIColor(hex: model.mobileAppDashboard.cardBackgroundColor)
        companyNameLabel.textColor = UIColor(hex: model.mobileAppDashboard.highlightTextColor)
        scoreCountLabel.textColor = UIColor(hex: model.mobileAppDashboard.highlightTextColor)
        scoreLabel.textColor = UIColor(hex: model.mobileAppDashboard.textColor)
        cashbackLabel.textColor = UIColor(hex: model.mobileAppDashboard.textColor)
        moreButton.backgroundColor = UIColor(hex: model.mobileAppDashboard.backgroundColor)
        moreButton.setTitleColor(UIColor(hex: model.mobileAppDashboard.mainColor), for: .normal)
        viewButton.tintColor = UIColor(hex: model.mobileAppDashboard.mainColor)
        deleteButton.tintColor = UIColor(hex: model.mobileAppDashboard.accentColor)
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        if let model = model, let type = MyButtonType(rawValue: sender.tag) {
            viewController?.interactor?.makeRequest(request: .getCompanyInfo(model, type))
        }
    }
}
