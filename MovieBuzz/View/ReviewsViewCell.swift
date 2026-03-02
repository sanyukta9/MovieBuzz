//
//  ReviewsViewCell.swift
//  MovieBuzz
//
//  Created by Sanyukta Adhate on 16/02/26.
//

import UIKit

class ReviewsViewCell: UITableViewCell {
    private var viewModel: ReviewsViewModelCell?
    
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
    
    func configure(with viewModel: ReviewsViewModelCell) {
        self.viewModel = viewModel
        collectionView.reloadData()
    }
    
}

extension ReviewsViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.reviewCount ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "ReviewsCollectionViewCell",
            for: indexPath
        ) as! ReviewsCollectionViewCell
        
        if let vmCell = viewModel?.reviewCellViewModel(at: indexPath.item) {
            cell.configure(with: vmCell)
        }
        return cell
    }
    
}
