//
//  SimilarViewCell.swift
//  MovieBuzz
//
//  Created by Sanyukta Adhate on 16/02/26.
//

import UIKit

class SimilarViewCell: UITableViewCell {
    private var similar: [Results] = []
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
            // Initialization code
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(
            UINib(nibName: "SimilarCollectionViewCell", bundle: nil),
            forCellWithReuseIdentifier: "SimilarCollectionViewCell"
        )
        
    }
    
    func configure(with similar: [Results]) {
        self.similar = similar
        collectionView.reloadData()
    }
    
}

extension SimilarViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return similar.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "SimilarCollectionViewCell",
            for: indexPath
        ) as! SimilarCollectionViewCell
        
        cell.configure(with: similar[indexPath.row])
        return cell
        
    }
}
