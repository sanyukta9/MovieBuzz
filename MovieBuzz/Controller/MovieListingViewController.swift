//
//  MovieListingViewController.swift
//  MovieBuzz
//
//  Created by Sanyukta Adhate on 12/02/26.
//

import UIKit

class MovieListingViewController: UIViewController {
    private var movies: [Results] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //connect table view to controller
        tableView.delegate = self
        tableView.dataSource = self
        fetchAllMovies()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // sender is the Book button, so find the cell
        guard segue.identifier == "MovieDetailsSegue", let detailVC = segue.destination as? MovieDetailViewController, let button = sender as? UIButton else { return }
        
        //button → contentView → cell
        var view = button.superview
        while view != nil && !(view is UITableViewCell) { view = view?.superview }
        
        //actual cell that was tapped
        if let cell = view as? UITableViewCell, let indexPath = tableView.indexPath(for: cell) {
            let movie = movies[indexPath.row]
            detailVC.movieId = movie.id
            print("Passing movieId: \(movie.id)")
        }
    }
    
    func fetchAllMovies() {
        //https://api.themoviedb.org/3/movie/now_playing?api_key=9a7a83ab6ed564c44e09ef91526db920
        let endpoint = Constants.baseURL + "/now_playing?api_key=" + Constants.apiKey
        MovieManager.shared.fetchData(TMDBResponse.self, urlString: endpoint) {
            [weak self] response in
            guard let self, let movies = response?.results else { return }
            self.movies = movies
            DispatchQueue.main.async {
                self.tableView.reloadData()
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
