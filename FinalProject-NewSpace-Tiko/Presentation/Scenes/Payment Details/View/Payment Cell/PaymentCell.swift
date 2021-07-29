//
//  PaymentCell.swift
//  FinalProject-NewSpace-Tiko
//
//  Created by Tiko on 22.07.21.
//

import UIKit
import Kingfisher

class PaymentCell: UITableViewCell {

    // MARK: - IBOutlets
    @IBOutlet private weak var categoryName: UILabel!
    @IBOutlet private weak var categoryImage: UIImageView!
    
    // MARK: - Life Cyrcle
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupLayout()
    }
    
    private func setupLayout() {
//        self.categoryImage.cornerView(cornerRadius: 10, borderWidth: 0.3, borderColor: .gray)
    }
    
    func configureCell(with item: Categories) {
        self.categoryName.text = item.name
    
        let url = URL(string: item.picture ?? "")
        categoryImage.kf.indicatorType = .activity
        categoryImage.kf.setImage(
            with: url,
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
