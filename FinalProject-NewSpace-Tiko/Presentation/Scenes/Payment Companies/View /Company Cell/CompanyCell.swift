//
//  CompanyCell.swift
//  FinalProject-NewSpace-Tiko
//
//  Created by Tiko on 20.07.21.
//

import UIKit
import Kingfisher

class CompanyCell: UITableViewCell {

    // MARK: - IBOutlets
    @IBOutlet private weak var companyName: UILabel!
    @IBOutlet private weak var companyImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupLayout()
    }

    private func setupLayout() {
//        self.companyImage.cornerView(cornerRadius: 10, borderWidth: 0.3, borderColor: .gray)
    }
    
    // MARK: - Configure cell
    func configure(with item: Companies) {
        companyName.text = item.name
        
        let url = URL(string: item.picture ?? "")
        companyImage.kf.indicatorType = .activity
        companyImage.kf.setImage(
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
