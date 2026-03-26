//
//  MovieListingViewController.swift
//  MovieBuzz
//
//  Created by Sanyukta Adhate on 12/02/26.
//
import UIKit
import Combine

class MovieListingViewController: UIViewController {
    private let viewModel = MovieListingViewModel()
    private let searchViewModel = SearchViewModel() //once created
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    private var cancellable = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //connect to controller
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        //setupBindings()
        //viewModel.delegate = self
        setupBindings()
        viewModel.fetchAllMovies()
    }
    
//    private func setupBindings() {
//        //install the phone
//        viewModel.isMoviesUpdated = { [weak self] in
//            self?.tableView.reloadData()
//        }
//        viewModel.isError = { message in
//            print("Error: \(message)")
//        }
//    }
    
    private func setupBindings() {
        viewModel.$movies
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.tableView.reloadData()
            }
            .store(in: &cancellable)
    }
    
        //runs before navigation to next screen and lets you pass the data.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            // sender is the Book UIButton which has no indexPath, no row number. To find the row, we need to find the UITableViewCell that contains this button.
        if segue.identifier == "MovieDetailsSegue" {
            guard let detailVC = segue.destination as? MovieDetailViewController,
                  let button = sender as? UIButton //is sender UIButton?
            else { return }
            
            
                //UIButton -> UIView(contentView)(.superview) ->   UITableViewCell
            var view = button.superview //contentView
            while view != nil && !(view is UITableViewCell) { view = view?.superview }
                //next iteration, view = contentView.superview = UITableViewCell
            
                //actual cell that was tapped: indexPath(row: 2, section: 0).
            if let cell = view as? UITableViewCell,
               let indexPath = tableView.indexPath(for: cell) {
                let movie = viewModel.movieAtIndex(at: indexPath.row)
                detailVC.viewModel = MovieDetailViewModel(movieId: movie.id)
            }
        }
        
            //passing movies to the searchVC
        if segue.identifier == "SearchSegue" {
            guard let searchVC = segue.destination as? SearchViewController else { return }
            print("prepare SearchSegue fired")
            searchViewModel.configure(with: viewModel.movies)
            searchVC.viewModel = searchViewModel //same obj passed every visit
        }
    }
}

extension MovieListingViewController: UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
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
    
    //through the segue directly land on searchPage instead of listingPage
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        performSegue(withIdentifier: "SearchSegue", sender: nil)
        return false //prevent keyboard opening on listingPage
    }
    
}

//extension MovieListingViewController: MovieListingDelegate {
//    func didUpdateMovies() {
//        tableView.reloadData()
//    }
//    
//    func didFailWithError(error: String) {
//        print("Error: \(error)")
//    }
//    
//}
