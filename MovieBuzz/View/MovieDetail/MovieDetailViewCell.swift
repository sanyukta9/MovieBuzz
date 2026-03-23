//
//  MovieDetailViewCell.swift
//  MovieBuzz
//
//  Created by Sanyukta Adhate on 13/02/26.
//

import UIKit

class MovieDetailViewCell: UITableViewCell {
    
    @IBOutlet weak var currentPoster: UIImageView!
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var votes: UILabel!
    @IBOutlet weak var currentMovie: UILabel!
    @IBOutlet weak var genre: UILabel!
    @IBOutlet weak var synopsis: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(with viewModel: MovieDetailViewModelCell) {
        currentPoster.loadImage(from: viewModel.posterURL)
        rating.text = viewModel.rating
        votes.text = viewModel.votes
        currentMovie.text = viewModel.currentMovie
        genre.text = viewModel.genre
        synopsis.text = viewModel.synopsis
    }
    
}
