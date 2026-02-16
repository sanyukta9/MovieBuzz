//
//  CastViewCell.swift
//  MovieBuzz
//
//  Created by Sanyukta Adhate on 16/02/26.
//

import UIKit

class CastViewCell: UITableViewCell {

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
    
}

extension CastViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "CastCollectionViewCell",
            for: indexPath
        )
        return cell
    }
    
    
}
