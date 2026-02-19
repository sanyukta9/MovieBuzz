//
//  CastViewCell.swift
//  MovieBuzz
//
//  Created by Sanyukta Adhate on 16/02/26.
//

import UIKit

class CastViewCell: UITableViewCell {
    private var casts: [CastResults] = []

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        //register ReviewsCollectionViewCell
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(
            UINib(nibName: "CastCollectionViewCell", bundle: nil),
            forCellWithReuseIdentifier: "CastCollectionViewCell"
        )
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(with casts: [CastResults]) {
        self.casts = casts
        collectionView.reloadData()
    }
    
}

extension CastViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return casts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "CastCollectionViewCell",
            for: indexPath
        ) as! CastCollectionViewCell
        
        cell.configure(with: casts[indexPath.item])
        return cell
    }
    
}
