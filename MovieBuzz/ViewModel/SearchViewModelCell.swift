//
//  SearchViewModelCell.swift
//  MovieBuzz
//
//  Created by Sanyukta Adhate on 12/03/26.
//

class SearchViewModelCell {
    
    //raw data
    private let movie: Results
    init(movie: Results) {
        self.movie = movie
    }
    
    var movieTitle: String {
        return movie.title
    }
    
    var posterURL: String? {
        return movie.posterURL
    }
}
