//
//  MovieListingViewModel.swift
//  MovieBuzz
//
//  Created by Sanyukta Adhate on 23/02/26.
//
import Foundation

class MovieListingViewModel {
    
    //MARK: - Read only for other classes. Only this VM modify. Property Observer. Notify to VC once updated.
    private(set) var movies: [Results] = [] {
        didSet { isMoviesUpdated?() }
    }
    
    //MARK: - MVVM Bindings. VC tells.
    var isMoviesUpdated : (() -> ())?
    var isError: ((String) -> (Void))?
    
    //MARK: - Computed Properties
    var moviesCount: Int { movies.count }
    func movieAtIndex(at index: Int) -> Results { movies[index] }
    
    //MARK: - Business logic
    func fetchAllMovies() {
        //https://api.themoviedb.org/3/movie/now_playing?api_key=9a7a83ab6ed564c44e09ef91526db920
        let endpoint = Constants.baseURL + "/now_playing?api_key=" + Constants.apiKey
        MovieManager.shared.fetchData(TMDBResponse.self, urlString: endpoint) { [weak self] response in
            guard let self else { return }
            guard let movies = response?.results else {
                self.isError?("Failed to load movies")
                return
            }
            DispatchQueue.main.async {
                //triggers didSet
                self.movies = movies
            }
        }
    }
}
