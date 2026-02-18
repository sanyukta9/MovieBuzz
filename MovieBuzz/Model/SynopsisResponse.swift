//
//  SynopsisResponse.swift
//  MovieBuzz
//
//  Created by Sanyukta Adhate on 18/02/26.
//

struct SynopsisResponse: Codable {
    let id: Int
    let original_title: String
    let poster_path: String?
    let genres: [Genres]
    let vote_average: Double //ratings
    let vote_count: Int //votes
    
    //computed property
    //https://image.tmdb.org/t/p/w500/wDWwtvkRRlgTiUr6TyLSMX8FCuZ.jpg
    var posterURL: String? {
        guard let posterPath = poster_path else { return nil}
        return Constants.posterImageURL + posterPath
    }
    
    //computed property
    //https://api.themoviedb.org/3/movie/9300?api_key=9a7a83ab6ed564c44e09ef91526db920
    var synopsisURL: String {
        return Constants.baseURL + "\(id)?api_key= \(Constants.apiKey)"
    }
}

struct Genres: Codable {
    //let id: Int
    let name: String
}
