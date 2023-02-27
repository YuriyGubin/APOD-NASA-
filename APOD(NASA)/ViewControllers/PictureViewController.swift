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
        fetchPictures()
    }

    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        pictures.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "picture", for: indexPath)
        guard let cell = cell as? PictureCell else { return UICollectionViewCell()}
        let reversedPictures = pictures.reversed()
        let picture = Array(reversedPictures)[indexPath.item]
        cell.configure(with: picture)
        cell.layer.cornerRadius = 5
        
        return cell
    }

    // MARK: UICollectionViewDelegate
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDetails", sender: nil)
    }
    
     // MARK: - Navigation
     
     
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         guard let indexPaths = collectionView.indexPathsForSelectedItems else { return }
         guard let detailVC = segue.destination as? DetailViewController else { return }
         let reversedPictures = pictures.reversed()
         indexPaths.forEach { indexPath in
             detailVC.picture = Array(reversedPictures)[indexPath.item]
         }
         
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

// MARK: - Size of collection view items
extension PictureViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: view.bounds.width / 2 - 12, height: view.bounds.width / 2 - 3)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 6, left: 6, bottom: 6, right: 6)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        6
    }
}
