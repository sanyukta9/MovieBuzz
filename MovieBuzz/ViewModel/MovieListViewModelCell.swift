//
//  MovieListViewModelCell.swift
//  MovieBuzz
//
//  Created by Sanyukta Adhate on 27/02/26.
//

import Foundation

class MovieListViewModelCell {
    
    //raw data
    private let movie: Results
    init(movie: Results) {
        self.movie = movie
    }
    
    var title: String {
        return movie.title
    }
    
    var formattedReleaseDate: String {
        return formatDate(movie.release_date)
    }
    
    var overview: String {
        return movie.overview
    }
    
    var posterURL: String? {
        return movie.posterURL
    }
    
        //MARK: - Data format for release data: 2023-03-15 but expected to show 15 March, 2023
    func formatDate(_ date: String) -> String {
            //read
        let returnedDate = DateFormatter()
        returnedDate.dateFormat = "yyyy-MM-dd"
        
        //convert to date
        guard let safeDate = returnedDate.date(from: date) else { return date }
        
            //write
        let expectedDate = DateFormatter()
        expectedDate.dateFormat = "dd MMMM, yyyy"
        
        return expectedDate.string(from: safeDate)
    }
}
