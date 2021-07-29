//
//  WelcomeCell.swift
//  FinalProject-NewSpace-Tiko
//
//  Created by Tiko on 16.07.21.
//

import UIKit

class WelcomeCell: UICollectionViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet weak var titleText: UILabel!
    @IBOutlet weak var coverImage: UIImageView!
    
    // MARK: - Life Cyrcle
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: - Set cell
    func configure(with item: Welcome){
        titleText.text = item.title
        coverImage.image = item.image
    }
}
