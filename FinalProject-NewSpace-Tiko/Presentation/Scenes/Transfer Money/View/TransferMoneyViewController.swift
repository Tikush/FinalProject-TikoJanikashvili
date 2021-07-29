//
//  TransferMoneyViewController.swift
//  FinalProject-NewSpace-Tiko
//
//  Created by Tiko on 22.07.21.
//

import UIKit

class TransferMoneyViewController: BaseViewController {
    
    // MARK: - IBOutlets
    @IBOutlet private weak var moneyLabel: UILabel!
    @IBOutlet private weak var contactImageView: UIImageView!
    @IBOutlet private weak var contactSymbolLabel: UILabel!
    @IBOutlet private weak var contactNumberLabel: UILabel!
    @IBOutlet private weak var contactNameLabel: UILabel!
    @IBOutlet private weak var nextButton: UIButton!
    
    // MARK: - Private Properties
    private var currentMoney = ""
    private var countRightNumber = 0
    private var alertMoneyService = AlertMoneyService()
    private var viewModel: TransferMoneyViewModelProtocol!
    private var commission = "0.00"
    
    // MARK: - Internal Properties
    var number: String?
    var name: String?
    var symbol: String?
    
    // MARK: Life Cyrcle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        configureViewModel()
    }
    
    private func setupLayout() {
        moneyLabel.text = "0"
        contactImageView.cornerView(cornerRadius: 10, borderWidth: 0.3, borderColor: .gray)
        contactNameLabel.text = name
        contactNumberLabel.text = number
        contactSymbolLabel.text = symbol
        contactImageView.cornerView(cornerRadius: 10, borderWidth: 0.3, borderColor: .lightGray)
        nextButton.customCornerButton(cornerRadius: 3, borderWidth: 0.2, borderColor: Constants.Color.brandBlue)
    }
    
    private func configureViewModel() {
        viewModel = TransferMoneyViewModel(with: self)
    }
    
    // MARK: - IBActions
    @IBAction private func back(_ sender: Any) {
        viewModel.controller.navigationController?.popViewController(animated: true)
    }
    
    @IBAction private func close(_ sender: Any) {
        viewModel.controller.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction private func onNext(_ sender: Any) {
        let alert = self.alertMoneyService.alert(money: moneyLabel.text!)
        if let value = Double(self.moneyLabel.text!), value < 1.00 {
            present(alert, animated: true)
            return
        } else  if let value = Double(self.currentMoney), value > 100000.00 {
            let alert = self.alertMoneyService.alert(money: moneyLabel.text!)
            present(alert, animated: true)
            return
        }
        if let value = Double(self.moneyLabel.text!), value < 50.00 {
            commission = "0.00"
        } else { commission = "0.90" }
        viewModel.controller.coordinator?.proceedToTransferGifPage(number: number ?? "", name: name ?? "", symbol: contactSymbolLabel.text ?? "", money: moneyLabel.text ?? "")
    }
    
    @IBAction private func configNumber(_ sender: UIButton) {
        if moneyLabel.text!.count == 6 {
            return
        } else {
            if sender.tag == 0, moneyLabel.text == "0" {
                return
            } else {
                currentMoney += "\(sender.tag)"
                if moneyLabel.text! == "0." {
                    currentMoney = "\(sender.tag)"
                    if countRightNumber == 2 {
                        return
                    } else {
                        countRightNumber += 1
                        currentMoney =  self.moneyLabel.text! + self.currentMoney
                    }
                } else {
                    if moneyLabel.text!.contains(".") {
                        if countRightNumber == 2 {
                            return
                        } else {
                            countRightNumber += 1
                        }
                    } else {
                        
                    }
                }
                moneyLabel.text! = currentMoney
            }
        }
    }
    
    @IBAction private func onDot(_ sender: Any) {
        if moneyLabel.text!.contains(".") {
            return
        } else {
            if moneyLabel.text!.count <= 5 {
                if moneyLabel.text == "0" {
                    moneyLabel.text! = moneyLabel.text! + "."
                } else {
                    currentMoney += "."
                    moneyLabel.text! = currentMoney
                }
            }
        }
    }
    
    @IBAction private func onClear(_ sender: UIButton) {
        if sender.tag == 11 {
            guard !moneyLabel.text!.isEmpty else { return }
            if moneyLabel.text!.contains(".") && countRightNumber > 0 {
                countRightNumber -= 1
            }
            moneyLabel.text?.remove(at: (moneyLabel.text?.index(before: moneyLabel.text!.endIndex))!)
            currentMoney = moneyLabel.text!
            if moneyLabel.text!.isEmpty || moneyLabel!.text == "0" {
                currentMoney = ""
                moneyLabel.text = "0"
            }
        }
    }
}
