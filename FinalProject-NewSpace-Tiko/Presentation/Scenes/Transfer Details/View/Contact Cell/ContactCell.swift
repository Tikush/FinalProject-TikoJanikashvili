//
//  ContactCell.swift
//  FinalProject-NewSpace-Tiko
//
//  Created by Tiko on 22.07.21.
//

import UIKit

protocol ContactCellDelegate: AnyObject {
    func fetchNumbers(_ number: Contact)
}

class ContactCell: UITableViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet private weak var fullNameLabel: UILabel!
    @IBOutlet private weak var numberLabel: UILabel!
    @IBOutlet private weak var symbolLabel: UILabel!
    @IBOutlet private weak var picture: UIImageView!

    // MARK: - Life Cyrcle
    override func awakeFromNib() {
        super.awakeFromNib()
        self.picture.cornerView(cornerRadius: 10, borderWidth: 0.3, borderColor: .gray)
    }
    
    override func prepareForReuse() {
        self.picture.image = nil
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
}
