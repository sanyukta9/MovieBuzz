//
//  MovieListingViewModel.swift
//  MovieBuzz
//
//  Created by Sanyukta Adhate on 23/02/26.
//

import Foundation
import Combine

//protocol
//protocol MovieListingDelegate: AnyObject {
//    func didUpdateMovies()
//    func didFailWithError(error: String)
//}

class MovieListingViewModel {
//    weak var delegate: MovieListingDelegate?
    
    //MARK: - Observer. Read only for other classes. Only this VM modify. Property Observer. Notify to VC once updated.
//    private(set) var movies: [Results] = [] {
//        //didSet { isMoviesUpdated?() }
//        didSet { delegate?.didUpdateMovies() }
//    }
    @Published private(set) var movies: [Results] = []
    
    //MARK: - MVVM Bindings. VC tells.
    //installs the phone socket
//    var isMoviesUpdated : (() -> ())?
//    var isError: ((String) -> (Void))?
    
    //MARK: - Computed Properties
    var moviesCount: Int { movies.count }
    func movieAtIndex(at index: Int) -> Results { movies[index] }
    func cellViewModel(at index: Int) -> MovieListViewModelCell {
        return MovieListViewModelCell(movie: movies[index])
    }
    
    //MARK: - Business logic
    func fetchAllMovies() {
        //https://api.themoviedb.org/3/movie/now_playing?api_key=9a7a83ab6ed564c44e09ef91526db920
        let endpoint = Constants.baseURL + "/now_playing?api_key=" + Constants.apiKey
        MovieManager.shared.fetchData(TMDBResponse.self, urlString: endpoint) { [weak self] response in
            guard let self else {
                return
            }
            guard let movies = response?.results else {
                print("Failed to load movies");
                return
            }
            self.movies = movies
//            DispatchQueue.main.async {
//                //triggers didSet
//                self.movies = movies //dials. No manual call: self.didUpdateMovies?()
//            }
        }
    }
}
