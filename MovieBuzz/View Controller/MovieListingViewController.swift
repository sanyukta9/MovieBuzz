//
//  MovieListingViewController.swift
//  MovieBuzz
//
//  Created by Sanyukta Adhate on 12/02/26.
//
import UIKit

class MovieListingViewController: UIViewController {
    private let viewModel = MovieListingViewModel()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
            // Do any additional setup after loading the view.
            //connect table view to controller
        tableView.delegate = self
        tableView.dataSource = self
        setupBindings()
        viewModel.fetchAllMovies()
    }
    
    private func setupBindings() {
        //install the phone
        viewModel.isMoviesUpdated = { [weak self] in
            self?.tableView.reloadData()
        }
        viewModel.isError = { message in
            print("Error: \(message)")
        }
    }
    
        //runs before navigation and lets you pass the data to next screen
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            // sender is the Book button, so find the cell
        guard segue.identifier == "MovieDetailsSegue",
              let detailVC = segue.destination as? MovieDetailViewController,
              let button = sender as? UIButton
        else { return }
        
        
            //UIButton -> UIView(contentView)(.superview) ->   UITableViewCell
        var view = button.superview
        while view != nil && !(view is UITableViewCell) { view = view?.superview }
        
            //actual cell that was tapped
        if let cell = view as? UITableViewCell,
           let indexPath = tableView.indexPath(for: cell) {
            let movie = viewModel.movieAtIndex(at: indexPath.row)
            detailVC.viewModel = MovieDetailViewModel(movieId: movie.id)
        }
    }
}

extension MovieListingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.moviesCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "MovieListViewCell",
            for: indexPath
        ) as! MovieListViewCell
        
        //get movie for ith row
        let movie = viewModel.cellViewModel(at: indexPath.row)
        //pass movie data to cell
        cell.configure(with: movie)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
    
}
