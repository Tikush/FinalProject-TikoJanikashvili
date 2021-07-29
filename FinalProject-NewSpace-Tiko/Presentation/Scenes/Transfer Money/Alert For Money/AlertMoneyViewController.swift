//
//  AlertMoneyViewController.swift
//  FinalProject-NewSpace-Tiko
//
//  Created by Tiko on 22.07.21.
//

import UIKit

class AlertMoneyViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet private weak var image: UIImageView!
    @IBOutlet private weak var closeButton: UIButton!
    @IBOutlet private weak var moneyView: UIView!
    @IBOutlet private weak var moreMoneyText: UILabel!
    @IBOutlet private weak var moneyLabel: UILabel!
    @IBOutlet private weak var lessMoneyText: UILabel!
    
    // MARK: - Properties
    var getMoney: String?
    
    // MARK: - View LifeCyrle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configuration()
        self.getInfo()
    }
    
    // MARK: - Configuration
    private func configuration() {
        self.moneyView.cornerView(cornerRadius: 10, borderWidth: 0.3, borderColor: .gray)
    }
    
    private func getInfo() {
        if let money = Double(getMoney!), money < 1.00 {
            if getMoney == "0" || getMoney == "0.0" { getMoney = "0.00"}
            self.moneyLabel.text = "მოთხოვნილი თანხა - \(getMoney!) ლარი"
            self.lessMoneyText.isHidden = false
            self.moreMoneyText.isHidden = true
        } else {
            self.moneyLabel.text = "მოთხოვნილი თანხა - \(getMoney!) ლარი"
            self.moreMoneyText.isHidden = false
            self.lessMoneyText.isHidden = true
        }
    }
    
    // MARK: - IBActions
    @IBAction private func close(_ sender: Any) {
        dismiss(animated: true)
    }
}
