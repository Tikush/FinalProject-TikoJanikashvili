//
//  ContentCell.swift
//  FinalProject-NewSpace-Tiko
//
//  Created by Tiko on 25.07.21.
//

import UIKit

class ContentCell: UITableViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet weak var contentLabel: UILabel!
    
    // MARK: - Life Cyrcle
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    func configure(with item: String) {
        contentLabel.text = item
    }
}
