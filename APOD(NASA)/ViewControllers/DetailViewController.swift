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
    
    var picture: Picture!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func setupViews() {
        NetworkManager.shared.fetchImage(from: picture.hdurl ?? picture.url) { [weak self] result in
            switch result {
            case .success(let imageData):
                self?.pictureHDImage.image = UIImage(data: imageData)
            case .failure(let error):
                print(error)
            }
        }
        
        descriptionTextView.text = """
\(picture.title)
\(picture.date)

\(picture.explanation)

\(String(describing: picture.copyright))
"""
    }

}
