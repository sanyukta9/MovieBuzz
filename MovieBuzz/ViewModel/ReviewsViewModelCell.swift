//
//  ReviewsViewModelCell.swift
//  MovieBuzz
//
//  Created by Sanyukta Adhate on 27/02/26.
//

import Foundation

class ReviewsViewModelCell {
    
    //raw data
    private var review: [ReviewsResults]
    init(review: [ReviewsResults]) {
        self.review = review
    }
    
    var reviewCount: Int {
        return review.count
    }
    
    func reviewCellViewModel(at index: Int) -> ReviewsCollectionViewModelCell{
        return ReviewsCollectionViewModelCell(reviews: review[index])
    }
    
}
