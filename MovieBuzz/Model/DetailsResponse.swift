//
//  DetailsResponse.swift
//  MovieBuzz
//
//  Created by Sanyukta Adhate on 18/02/26.
//

//MARK: - Movie Details Header

struct DetailsResponse: Codable {
    let id: Int
    let original_title: String
    let poster_path: String?
    let genres: [Genre]
    let vote_average: Double //ratings
    let vote_count: Int //votes
    
    //computed property
    //https://image.tmdb.org/t/p/w500/wDWwtvkRRlgTiUr6TyLSMX8FCuZ.jpg
    var posterURL: String? {
        guard let posterPath = poster_path else { return nil}
        return Constants.posterImageURL + posterPath
    }
    
    //[] -> a,b
    var genreNames: String {
        return genres.map(\.name).joined(separator: ", ")
    }
}

struct Genre: Codable {
    //let id: Int
    let name: String
}
