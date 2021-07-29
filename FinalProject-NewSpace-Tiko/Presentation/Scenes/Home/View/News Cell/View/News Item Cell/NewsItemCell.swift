//
//  CoverItemCell.swift
//  FinalProject-NewSpace-Tiko
//
//  Created by Tiko on 25.07.21.
//

import UIKit
import Kingfisher

class NewsItemCell: UICollectionViewCell {

    @IBOutlet weak var booknewsImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        booknewsImage.cornerView(cornerRadius: 15, borderWidth: 0.3, borderColor: Constants.Color.brandBlue)
    }

    func configure(with item: News) {
        booknewsImage.kf.indicatorType = .activity
        booknewsImage.kf.setImage(
            with: URL(string: item.image ?? ""),
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


