//
//  GifsCell.swift
//  FinalProject-NewSpace-Tiko
//
//  Created by Tiko on 23.07.21.
//

import UIKit
import Kingfisher

class GifsCell: UICollectionViewCell {

    // MARK: - IBOutlets
    @IBOutlet private weak var gifImage: UIImageView!
    
    // MARK: - View LifeCyrle
    override func awakeFromNib() {
        super.awakeFromNib()
        gifImage.cornerView(cornerRadius: 10, borderWidth: 0.3, borderColor: .gray)
    }
    
    func setCell(with url: String) {
        let urlImage = URL(string: url)
        self.gifImage.kf.indicatorType = .activity
        self.gifImage.kf.setImage(
            with: urlImage,
            options: [
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ])
        {
            result in
            switch result {
            case .success(let value):
                print("Task done for: \(value.source.url?.absoluteString ?? "")")
            case .failure(let error):
                print("Job failed: \(error.localizedDescription)")
            }
        }
    }
}
