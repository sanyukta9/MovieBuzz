//
//  CastCollectionViewModelCell.swift
//  MovieBuzz
//
//  Created by Sanyukta Adhate on 27/02/26.
//

import Foundation

class CastCollectionViewModelCell {
    
    //raw data
    private let casts: CastResults
    init(casts: CastResults) {
        self.casts = casts
    }
    
    var castImage: String? {
        return casts.profilePathURL
    }
    
    var castFullName: String {
        return casts.name
    }
    
    var castShortName: String {
        return casts.character
    }
    
}
