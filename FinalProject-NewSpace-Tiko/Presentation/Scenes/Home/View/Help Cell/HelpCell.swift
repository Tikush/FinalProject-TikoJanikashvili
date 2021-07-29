//
//  HelpCell.swift
//  FinalProject-NewSpace-Tiko
//
//  Created by Tiko on 25.07.21.
//

import UIKit

class HelpCell: UITableViewCell {

    // MARK: - IBOutlets
    @IBOutlet private weak var mainView: UIView!
    @IBOutlet private weak var iconView: UIView!
    
    // MARK: - Life Cyrcle
    override func awakeFromNib() {
        super.awakeFromNib()
        setupLayout()
    }

    private func setupLayout() {
        mainView.cornerView(cornerRadius: 10, borderWidth: 0.3, borderColor: Constants.Color.brandBlue)
        iconView.cornerView(cornerRadius: iconView.bounds.height / 2, borderWidth: 0.3, borderColor: Constants.Color.brandBlue)
    }
}
