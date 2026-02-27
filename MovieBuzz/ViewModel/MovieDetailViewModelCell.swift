//
//  MovieDetailViewModelCell.swift
//  MovieBuzz
//
//  Created by Sanyukta Adhate on 27/02/26.
//

import Foundation
class MovieDetailViewModelCell {
    
    //raw data
    private var details: DetailsResponse
    init(details: DetailsResponse) {
        self.details = details
    }
    
    var posterURL: String? {
        return details.posterURL
    }
    
    var rating: String {
        return String(format: "%.1f/10", details.vote_average)
    }
    
    var votes: String {
        return "\(details.vote_count) votes"
    }
    
    var currentMovie: String {
        return details.original_title
    }
    
    var genre: String {
        return details.genreNames
    }
    
    var synopsis: String {
        return details.overview
    }

}
