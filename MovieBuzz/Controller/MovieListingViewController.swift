//
//  MovieListingViewController.swift
//  MovieBuzz
//
//  Created by Sanyukta Adhate on 12/02/26.
//

import UIKit

class MovieListingViewController: UIViewController {
    var movieManager = MovieManager()
    var movies: [Results] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //connect table view to controller
        tableView.delegate = self
        tableView.dataSource = self
        fetchAllMovies()
    }
    
    func fetchAllMovies() {
        let endpoint = Constants.baseURL + Constants.nowPlaying + "?api_key=" + Constants.apiKey
        movieManager.fetchMovies(urlString: endpoint) { [weak self] movies in
            guard let self = self else { return }
                // Store movies in the correct category index
            if let movies = movies {
                self.movies = movies
                    // Reload table view on the MAIN thread
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
        
    }
    
}

extension MovieListingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "MovieListViewCell",
            for: indexPath
        ) as! MovieListViewCell
        
        //get movie for ith row
        let movie = movies[indexPath.row]
        //pass movie data to cell
        cell.configure(with: movie)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
    
}
