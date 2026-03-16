//
//  SearchViewModel.swift
//  MovieBuzz
//
//  Created by Sanyukta Adhate on 12/03/26.
//

import Foundation

//protocol
protocol SearchDelegate: AnyObject {
    func didSearchMovies()
    func didFailWithError(error: String)
}

class SearchViewModel {
    weak var delegate: SearchDelegate?
    
    var searchAllMovies: [Results] = []
    
        //MARK: - Observer. Read only for other classes. Only this VM modify. Property Observer. Notify to VC once updated.
    private(set) var searchMovies: [Results] = [] {
            //didSet { isSearchUpdated?() }
        didSet { delegate?.didSearchMovies() }
    }
    private(set) var recentMovies: [Results] = [] {
            //didSet { isRecentUpdated?() }
        didSet { delegate?.didSearchMovies() }
    }
    
        // MARK: - State
    private(set) var isSearching: Bool = false
    
        // MARK: - What table reads from
    var displayMovies: [Results] {
        return isSearching ? searchMovies : recentMovies
    }
    
    //MARK: - now_playing api for local filter. Injecting config method.
    func configure(with movies: [Results]) {
        self.searchAllMovies = movies
        print("SearchViewModel loaded \(movies.count) movies")
    }
    
        //MARK: - Computed Properties
    var moviesCount: Int { displayMovies.count }
    func movieAtIndex(at index: Int) -> Results { displayMovies[index] }
    func cellViewModel(at index: Int) -> SearchViewModelCell {
        return SearchViewModelCell(movie: displayMovies[index])
    }
        
        //MARK: - MVVM Bindings. VC tells.
    //installs the phone socket
//        var isMoviesUpdated : (() -> ())?
//        var isError: ((String) -> (Void))?
    
        //MARK: - Business logic
    func searchMovies(searchedMovie: String) {
        let trimSearched = searchedMovie.trimmingCharacters(in: .whitespaces)
        guard !trimSearched.isEmpty else {isSearching = false; searchMovies = []; return}
        isSearching = true
        searchMovies = searchAllMovies.filter {
            $0.title.lowercased().contains(trimSearched.lowercased())
        }
    }
    
    func saveToRecents(_ movie: Results) {
        var recents = recentMovies
        recents.removeAll { $0.id == movie.id }
        recents.insert(movie, at: 0)
        recentMovies = Array(recents.prefix(5))
    }
    
    func clearSearch() {
        isSearching = false
        searchMovies = []
    }
}
