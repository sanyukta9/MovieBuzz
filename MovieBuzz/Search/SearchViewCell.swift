//
//  SearchViewCell.swift
//  MovieBuzz
//
//  Created by Sanyukta Adhate on 11/03/26.
//
import UIKit

class SearchViewCell: UITableViewCell {
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var movieName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
            // Initialization code
    }
    
    // Configure cell with movie data
    func configure(with viewModel: SearchViewModelCell) {
        posterImage.loadImage(from: viewModel.posterURL)
        movieName.text = viewModel.movieTitle
    }
    
    //MARK: - Clean up when cell is reused
    override func prepareForReuse() {
        super.prepareForReuse()
        movieName.text = nil
        posterImage.image = nil
    }
}
