//
//  TransactionCell.swift
//  FinalProject-NewSpace-Tiko
//
//  Created by Tiko on 24.07.21.
//

import UIKit

class TransactionCell: UITableViewCell {

    // MARK: - IBOutlets
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var transactionImage: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var roundView: UIView!
    
    // MARK: - Life Cyrcle
    override func awakeFromNib() {
        super.awakeFromNib()
        roundView.cornerView(cornerRadius: roundView.frame.height/2, borderWidth: 0.2, borderColor: Constants.Color.brandBlue)
    }
    
    func configure(with item: Transaction) {
        if item.color == "green" {
            amountLabel.textColor = Constants.Color.payGreen
            amountLabel.text = "+ \(item.amount ?? "") ლ"
            nameLabel.text = item.name
        } else if item.color == "red" {
            amountLabel.textColor = Constants.Color.lightRed
            amountLabel.text = "- \(item.amount ?? "") ლ"
            nameLabel.text = item.name
        } else {
            amountLabel.textColor = Constants.Color.lightRed
            amountLabel.text = "- \(item.amount ?? "") ლ"
            nameLabel.text = "თქვენ გადარიცხეთ თანხა"
        }
        timeLabel.text = item.time
        
    }
}
