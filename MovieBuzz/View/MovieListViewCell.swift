    //
    //  MovieListViewCell.swift
    //  MovieBuzz
    //
    //  Created by Sanyukta Adhate on 12/02/26.
    //
//One row in table

import UIKit

class MovieListViewCell: UITableViewCell {
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var movieName: UILabel!
    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var overview: UILabel!
    @IBOutlet weak var book: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
        // Configure cell with movie data
    func configure(with viewModel: MovieListViewModelCell) {
        movieName.text = viewModel.title
        releaseDate.text = viewModel.formattedReleaseDate
        overview.text = viewModel.overview
        // Load poster image
        guard let posterImageView else { showPlaceholder(); return }
        posterImageView.loadImage(from: viewModel.posterURL)
    }
    
        //MARK: - Show placeholder if image fails
    func showPlaceholder() {
        posterImageView.image = UIImage(systemName: "film.fill")
        posterImageView.tintColor = .systemGray
        posterImageView.contentMode = .center
    }
    
        //MARK: - Clean up when cell is reused
    override func prepareForReuse() {
        super.prepareForReuse()
        movieName.text = nil
        releaseDate.text = nil
        overview.text = nil
        posterImageView.image = nil
    }
    
}
