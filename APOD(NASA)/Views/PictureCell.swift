//
//  PictureCell.swift
//  APOD(NASA)
//
//  Created by Yuriy on 24.02.2023.
//

import UIKit

class PictureCell: UICollectionViewCell {
    
    @IBOutlet var pictureImage: UIImageView!
    @IBOutlet var descriptionLabel: UILabel!
    
    func configure(with picture: Picture) {
        descriptionLabel.text = """
\(picture.date)
\(picture.title)
"""
        NetworkManager.shared.fetchImage(from: picture.url) { [weak self] result in
            switch result {
            case .success(let imageData):
                self?.pictureImage.image = UIImage(data: imageData)
            case .failure(let error):
                print(error)
            }
        }
    }
}
