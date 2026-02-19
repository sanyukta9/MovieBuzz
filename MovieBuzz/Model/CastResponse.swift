//
//  CastResponse.swift
//  MovieBuzz
//
//  Created by Sanyukta Adhate on 18/02/26.
//

struct CastResponse: Codable{
    let cast: [CastResults]
}

struct CastResults: Codable {
    let name: String
    let character: String
    let profile_path: String?
    
    //computed property
    //https://image.tmdb.org/t/p/w500/i54XoxYieuff2w6MwyfwVUBvmR0.jpg
    var profilePathURL: String? {
        guard let profilePath = profile_path else { return nil }
        return Constants.posterImageURL + profilePath
    }
}

