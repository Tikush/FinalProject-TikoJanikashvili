//
//  InviteFriendCell.swift
//  FinalProject-NewSpace-Tiko
//
//  Created by Tiko on 25.07.21.
//

import UIKit

class InviteFriendCell: UITableViewCell {

    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var iconView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupLayout()
    }
    
    private func setupLayout() {
        mainView.cornerView(cornerRadius: 10, borderWidth: 0.3, borderColor: Constants.Color.brandBlue)
        iconView.cornerView(cornerRadius: iconView.bounds.height / 2, borderWidth: 0.3, borderColor: Constants.Color.brandBlue)
    }
}
