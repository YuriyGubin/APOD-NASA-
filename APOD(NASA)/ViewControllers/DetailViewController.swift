//
//  DetailViewController.swift
//  APOD(NASA)
//
//  Created by Yuriy on 24.02.2023.
//

import UIKit

final class DetailViewController: UIViewController {
    
    @IBOutlet var pictureHDImage: UIImageView!
    @IBOutlet var descriptionTextView: UITextView!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var titleLabel: UILabel!
    
    var picture: Picture!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        setupViews()
    }
    
    private func setupViews() {
        NetworkManager.shared.fetchImage(from: picture.hdurl ?? picture.url) { [weak self] result in
            switch result {
            case .success(let imageData):
                self?.pictureHDImage.image = UIImage(data: imageData)
                self?.activityIndicator.stopAnimating()
            case .failure(let error):
                print(error)
            }
        }
        title = picture.date
        titleLabel.textColor = .orange
        titleLabel.font.withSize(20)
        titleLabel.text = picture.title
        descriptionTextView.text = """
\(picture.explanation)

\(picture.copyright ?? "")
"""
    }

}
