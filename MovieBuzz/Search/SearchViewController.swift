//
//  SearchViewController.swift
//  MovieBuzz
//
//  Created by Sanyukta Adhate on 11/03/26.
//

import UIKit

class SearchViewController: UIViewController {
    
    var viewModel = SearchViewModel()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var recentLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
        viewModel.delegate = self
        searchBar.delegate = self
        recentLabel.isHidden = true // hidden by default
        navigationItem.hidesBackButton = true // hide default back
    }
    
    // keyboard opens after screen appears
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //syncs UI with VM state
        didSearchMovies()
        
        if !viewModel.lastSearch.isEmpty {
            searchBar.text = viewModel.lastSearch
            searchBar.setShowsCancelButton(true, animated: false)  // X button
            searchBar.becomeFirstResponder()
        } else {
            searchBar.becomeFirstResponder()
        }

    }
    
    //pass movies to SearchVC
    func configure(with movies: [Results]) {
        viewModel.configure(with: movies)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.moviesCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "SearchViewCell",
            for: indexPath
        ) as! SearchViewCell
        cell.configure(with: viewModel.cellViewModel(at: indexPath.row))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //triggered when the user taps on row
        let movie = viewModel.movieAtIndex(at: indexPath.row)
        //save tapped movie to recent list
        viewModel.saveToRecents(movie)
        //open main storyboard
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        //create obj of detail screen
        let detailVC = storyboard.instantiateViewController(
            withIdentifier: "MovieDetailViewController"
        ) as! MovieDetailViewController
        //passing data to detail screen (Dep.Inj.)
        detailVC.viewModel = MovieDetailViewModel(movieId: movie.id)
        //switch to detail screen
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    
    //MARK: - Search Bar

        //on every keystroke, textDidChange fires
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.searchMovies(searchedMovie: searchText)
    }
    
        // go back on cancel tap
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        navigationController?.popViewController(animated: true)
    }
    
        // show X when searchBar active
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
    }

    
}

extension SearchViewController: SearchDelegate {
    func didSearchMovies() {
        recentLabel.isHidden = viewModel.shouldShowRecentLabel
        tableView.reloadData()
    }
    
    func didFailWithError(error: String) {
        print("Error: \(error)")
    }
}

