//
//  SimilarCollectionViewCell.swift
//  MovieBuzz
//
//  Created by Sanyukta Adhate on 16/02/26.
//

import UIKit

class SimilarCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var similarPosterImage: UIImageView!
    
    @IBOutlet weak var similarMovieName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        similarPosterImage.layer.cornerRadius = 12
    }
    
    func configure(with similar: Results) {
        similarPosterImage.loadImage(from: similar.posterURL)
        similarMovieName.text = similar.title
    }

}
