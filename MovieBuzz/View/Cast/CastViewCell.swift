//
//  CastViewCell.swift
//  MovieBuzz
//
//  Created by Sanyukta Adhate on 16/02/26.
//

import UIKit

class CastViewCell: UITableViewCell {
    private var viewModel: CastViewModelCell?

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
    
    func configure(with viewModel: CastViewModelCell) {
        self.viewModel = viewModel
        collectionView.reloadData()
    }
    
}

extension CastViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.castCount ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "CastCollectionViewCell",
            for: indexPath
        ) as! CastCollectionViewCell
        
        if let vmCell = viewModel?.castCellViewModel(at: indexPath.item){
            cell.configure(with: vmCell)
        }
        return cell
    }
    
}
