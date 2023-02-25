//
//  PictureViewController.swift
//  APOD(NASA)
//
//  Created by Yuriy on 24.02.2023.
//

import UIKit

class PictureViewController: UICollectionViewController {
    
    var pictures: [Picture] = []

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        pictures.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "picture", for: indexPath)
        guard let cell = cell as? PictureCell else { return UICollectionViewCell()}
        let picture = pictures[indexPath.item]
        cell.configure(with: picture)
    
        return cell
    }

    // MARK: UICollectionViewDelegate

    
     // MARK: - Navigation
     
     
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     }
    
}

// MARK: - Networking
extension PictureViewController {
    func fetchPictures() {
        NetworkManager.shared.fetchPictures(from: Link.pictureUrl.rawValue) { [weak self] result in
            switch result {
            case .success(let pictures):
                self?.pictures = pictures
                self?.collectionView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

// MARK: -
extension PictureViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: UIScreen.main.bounds.width / 2 - 6, height: UIScreen.main.bounds.width / 2)
    }
}
