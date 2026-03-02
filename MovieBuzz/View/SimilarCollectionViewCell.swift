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
    
    func configure(with viewModel: SimilarCollectionViewModelCell) {
        similarPosterImage.loadImage(from: viewModel.similarPosterImage)
        similarMovieName.text = viewModel.similarMovieName
    }

}
