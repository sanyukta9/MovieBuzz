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
    private(set) var lastSearch: String = "" 
    
        // MARK: - What table reads from
    var displayMovies: [Results] {
        return isSearching ? searchMovies : recentMovies
    }
    
    var shouldShowRecentLabel: Bool {
        return isSearching || recentMovies.isEmpty
    }
    
    //MARK: - now_playing api for local filter. Injecting config method.
    func configure(with movies: [Results]) {
        guard searchAllMovies.isEmpty else { return }
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
        let trimSearched = searchedMovie.trimmingCharacters(in: .whitespaces).lowercased()
        
        lastSearch = trimSearched
        
        guard !trimSearched.isEmpty else {isSearching = false; searchMovies = []; return}
        isSearching = true
        
            //break user search into words
        let searchWords = trimSearched.components(separatedBy: " ").filter{!$0.isEmpty}
        
        searchMovies = searchAllMovies.filter { movie in
                //break movie title into words , remove empty strings
            let titleWords = movie.title.lowercased().components(separatedBy: " ").filter{!$0.isEmpty}
            
                //every search word must match start of any title word
            return searchWords.allSatisfy { searchWord in
                titleWords.contains { titleWord in
                    titleWord.hasPrefix(searchWord)
                }
            }
        }
    }
    
    func saveToRecents(_ movie: Results) {
        var recents = recentMovies
        recents.removeAll { $0.id == movie.id } // no duplicates
        recents.insert(movie, at: 0)            // most recent first
        recentMovies = Array(recents.prefix(5)) // keeping last 5
    }
    
    func clearSearch() {
        isSearching = false
        searchMovies = []
        lastSearch = ""
    }
}
