//
//  ReviewsCollectionViewModelCell.swift
//  MovieBuzz
//
//  Created by Sanyukta Adhate on 27/02/26.
//

import Foundation

class ReviewsCollectionViewModelCell {
    
    //raw data
    private let reviews: ReviewsResults
    init(reviews: ReviewsResults) {
        self.reviews = reviews
    }
    
    var reviewerName: String {
        return reviews.author
    }
    
    var reviewContent: String {
        return reviews.content
    }
    
}
