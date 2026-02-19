//
//  ReviewsViewCell.swift
//  MovieBuzz
//
//  Created by Sanyukta Adhate on 16/02/26.
//

import UIKit

class ReviewsViewCell: UITableViewCell {
    private var reviews: [ReviewsResults] = []
    
    @IBOutlet weak var collectionView: UICollectionView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        //register ReviewsCollectionViewCell
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(
            UINib(nibName: "ReviewsCollectionViewCell", bundle: nil),
            forCellWithReuseIdentifier: "ReviewsCollectionViewCell"
        )
    }
    
    func configure(with reviews: [ReviewsResults]) {
        self.reviews = reviews
        collectionView.reloadData()
    }
    
}

extension ReviewsViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return reviews.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "ReviewsCollectionViewCell",
            for: indexPath
        ) as! ReviewsCollectionViewCell
        
        cell.configure(with: reviews[indexPath.item])
        return cell
    }
    
}
