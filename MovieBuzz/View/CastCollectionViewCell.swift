//
//  CastCollectionViewCell.swift
//  MovieBuzz
//
//  Created by Sanyukta Adhate on 16/02/26.
//

import UIKit

class CastCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var castImage: UIImageView!
    
    @IBOutlet weak var castFullName: UILabel!
    
    @IBOutlet weak var castShortName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        castImage.layer.cornerRadius = castImage.frame.width / 2
        castImage.clipsToBounds = true
    }
    
    func configure(with casts: CastResults) {
        castImage.loadImage(from: casts.profilePathURL)
        castFullName.text = casts.name
        castShortName.text = casts.character
    }

}
