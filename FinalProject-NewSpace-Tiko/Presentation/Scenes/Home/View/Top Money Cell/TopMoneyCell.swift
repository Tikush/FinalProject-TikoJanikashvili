//
//  TopMoneyCell.swift
//  FinalProject-NewSpace-Tiko
//
//  Created by Tiko on 25.07.21.
//

import UIKit
import Firebase

class TopMoneyCell: UITableViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet weak var monayLabel: UILabel!
    @IBOutlet weak var monayView: UIView!
    
    // MARK: - Private Properties
    private var viewModel: TopMoneyViewModelProtocol!
    private var currenrUser: User!
    private var money: String?
    
    // MARK: - Life Cyrcle
    override func awakeFromNib() {
        super.awakeFromNib()
        setupLayout()
        configureViewModel()
    }
    
    private func setupLayout() {
        monayView.cornerView(cornerRadius: monayView.bounds.height / 2, borderWidth: 2, borderColor: Constants.Color.brandBlue)
    }
    
    private func setMoneyText(with label: UILabel) {
        if let largeFont = UIFont(name: "Helvetica", size: 22), let superScriptFont = UIFont(name: "Helvetica", size:12) {
            let numberString = NSMutableAttributedString(string: label.text ?? "", attributes: [.font: largeFont])
            numberString.append(NSAttributedString(string: "ლ", attributes: [.font: superScriptFont, .baselineOffset: 10]))
            label.attributedText = numberString
        }
    }
    
    private func configureViewModel() {
        let user = Auth.auth().currentUser
        if let user = user {
            currenrUser = User(uid: user.uid, email: user.email ?? "", phone: user.phoneNumber ?? "")
        }
        viewModel = TopMoneyViewModel()
        viewModel.fetchAmountByUser(with: currenrUser, refKey: RefPoints.userDetails.rawValue) { [weak self] currentAmount in
            print("currentAmount \(currentAmount)")
            self?.monayLabel.text = currentAmount
        }
    }
}
