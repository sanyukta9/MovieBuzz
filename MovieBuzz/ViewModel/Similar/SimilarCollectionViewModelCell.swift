//
//  SimilarCollectionViewModelCell.swift
//  MovieBuzz
//
//  Created by Sanyukta Adhate on 27/02/26.
//

import Foundation

class SimilarCollectionViewModelCell {
    private let similar: Results
    init(similar: Results) {
        self.similar = similar
    }
    
    var similarPosterImage: String? {
        return similar.posterURL
    }
    
    var similarMovieName: String {
        return similar.title
    }
}
