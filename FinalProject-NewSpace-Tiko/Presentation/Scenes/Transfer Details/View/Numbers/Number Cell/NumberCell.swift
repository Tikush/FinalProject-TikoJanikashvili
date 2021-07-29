//
//  NumberCell.swift
//  FinalProject-NewSpace-Tiko
//
//  Created by Tiko on 22.07.21.
//

import UIKit

class NumberCell: UITableViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet private weak var numberLabel: UILabel!

    // MARK: - Life Cyrcle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(with number: String) {
        self.numberLabel.text = number
    }
}
