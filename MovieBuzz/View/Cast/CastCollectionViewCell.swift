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
    
    //calls before autolayout constraints set: width is not set yet
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    //called after autolayout constraints set: width set to calculate radius of circle
    override func layoutSubviews() {
        super.layoutSubviews()
        castImage.layer.cornerRadius = castImage.frame.width / 2
        castImage.clipsToBounds = true
    }
    
    func configure(with viewModel: CastCollectionViewModelCell) {
        castImage.loadImage(from: viewModel.castImage)
        castFullName.text = viewModel.castFullName
        castShortName.text = viewModel.castShortName
    }

}
