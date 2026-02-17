//
//  ReviewsCollectionViewCell.swift
//  MovieBuzz
//
//  Created by Sanyukta Adhate on 16/02/26.
//

import UIKit

class ReviewsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var reviewerName: UILabel!
    @IBOutlet weak var reviewContent: UILabel!
    
    @IBOutlet weak var collectionViewCell: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        collectionViewCell.layer.cornerRadius = 10
    }

}
