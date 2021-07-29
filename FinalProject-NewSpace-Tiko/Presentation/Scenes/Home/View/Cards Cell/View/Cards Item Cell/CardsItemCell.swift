//
//  CardsItemCell.swift
//  FinalProject-NewSpace-Tiko
//
//  Created by Tiko on 25.07.21.
//

import UIKit

class CardsItemCell: UICollectionViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet weak var cardImage: UIImageView!
    @IBOutlet weak var cardNameLabel: UILabel!
    @IBOutlet weak var codeLabel: UILabel!
    
    // MARK: - Life Cyrcle
    override func awakeFromNib() {
        super.awakeFromNib()    }
    
    func configure(with item: Card) {
        cardImage.image = item.image
        cardNameLabel.text = item.name ?? ""
        codeLabel.text = item.number ?? ""
    }
}
