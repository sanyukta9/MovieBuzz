//
//  CastViewModelCell.swift
//  MovieBuzz
//
//  Created by Sanyukta Adhate on 27/02/26.
//

import Foundation

class CastViewModelCell {
    private let casts: [CastResults]
    init(casts: [CastResults]) {
        self.casts = casts
    }
    
    var castCount: Int {
        return casts.count
    }
    
    func castCellViewModel(at index: Int) -> CastCollectionViewModelCell{
        return CastCollectionViewModelCell(casts: casts[index])
    }
}
