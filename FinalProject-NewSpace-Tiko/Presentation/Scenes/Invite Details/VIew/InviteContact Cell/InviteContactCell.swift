//
//  InviteContactCell.swift
//  FinalProject-NewSpace-Tiko
//
//  Created by Tiko on 28.07.21.
//

import UIKit

protocol InviteContactDelegate: AnyObject {
    func sendMessage(with phoneNumber: String)
}

class InviteContactCell: UITableViewCell {

    // MARK: - IBOutlets
    @IBOutlet private weak var fullNameLabel: UILabel!
    @IBOutlet private weak var numberLabel: UILabel!
    @IBOutlet private weak var symbolLabel: UILabel!
    @IBOutlet private weak var picture: UIImageView!
    @IBOutlet private weak var inviteButton: UIButton!
    @IBOutlet private weak var buttonView: UIView!
    
    weak var delegate: InviteContactDelegate?
    
    // MARK: - Life Cyrcle
    override func awakeFromNib() {
        super.awakeFromNib()
        setupLayout()
    }
    
    override func prepareForReuse() {
        self.picture.image = nil
    }
    
    private func setupLayout() {
        picture.cornerView(cornerRadius: 10, borderWidth: 0.3, borderColor: .gray)
        buttonView.cornerView(cornerRadius: 10, borderWidth: 0.3, borderColor: .gray)
    }
    
    func configure(with item: Contact) {
        self.fullNameLabel.text = "\(item.name) \(item.lastName)"
        self.numberLabel.text = item.number
        if item.picture != nil {
            self.picture.isHidden = false
            self.symbolLabel.isHidden = true
            self.picture.image = UIImage(data: item.picture!)
        } else {
            self.symbolLabel.isHidden = false
            self.symbolLabel.text = item.symbol
        }
    }
    
    @IBAction func onInvite(_ sender: Any) {
        delegate?.sendMessage(with: numberLabel.text ?? "")
    }
}
