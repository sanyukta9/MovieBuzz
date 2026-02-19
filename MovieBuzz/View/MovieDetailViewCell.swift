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
    
    func configure(with details: DetailsResponse) {
        currentPoster.loadImage(from: details.posterURL)
        rating.text = String(format: "%.1f/10", details.vote_average)
        votes.text = "\(details.vote_count) votes"
        currentMovie.text = details.original_title
        genre.text = details.genreNames
        synopsis.text = details.overview
    }
    
}
