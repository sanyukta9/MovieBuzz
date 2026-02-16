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
    func configure(with movie: Results) {
        movieName.text = movie.title
        releaseDate.text = formatDate(movie.release_date)
        overview.text = movie.overview
            // Load poster image
        if let posterURL = movie.posterURL {
            loadImage(from: posterURL)
        } else {
            showPlaceholder()
        }
    }
    
        //MARK: - Load the poster image from URL
    
    func loadImage(from urlString: String) {
        let urlString = urlString
            //1. Create a URL from a string
        guard let url = URL(string: urlString) else { showPlaceholder(); return }
            //2. Create a URLSession
        let session = URLSession.shared
            //3. Give URL session a task to fetch data from the Server (asynchronous)
        let task = session.dataTask(with: url) {[weak self] data, response, error in
            guard let safeData = data, error == nil else {
                print("Error loading image: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
                //4. Parse Converts raw image data into a UIImage
            guard let image = UIImage(data: safeData) else {
                DispatchQueue.main.async {
                    self?.showPlaceholder()
                }
                return
            }
            
            DispatchQueue.main.async {
                self?.posterImageView.image = image
            }
        }
            //5. Start the task
        task.resume()
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
    
        //MARK: - Data format for release data: 2023-03-15 but expected to show 15 March, 2023
    func formatDate(_ date: String) -> String {
        //read
        let returnedDate = DateFormatter()
        returnedDate.dateFormat = "yyyy-MM-dd"
        
        guard let safeDate = returnedDate.date(from: date) else { return date }
        
        //write
        let expectedDate = DateFormatter()
        expectedDate.dateFormat = "dd MMMM, yyyy"
        
        return expectedDate.string(from: safeDate)
    }
    
}
