//
//  SimilarViewModelCell.swift
//  MovieBuzz
//
//  Created by Sanyukta Adhate on 27/02/26.
//

import Foundation

class SimilarViewModelCell {
    
    //raw data
    private var similar: [Results]
    init(similar: [Results]) {
        self.similar = similar
    }
    
    var similarCount: Int {
        return similar.count
    }
    
    func similarCellViewModel(at index: Int) -> SimilarCollectionViewModelCell{
        return SimilarCollectionViewModelCell(similar: similar[index])
    }
}
