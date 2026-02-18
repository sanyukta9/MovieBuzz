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
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
