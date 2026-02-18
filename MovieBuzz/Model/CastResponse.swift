//
//  CastResponse.swift
//  MovieBuzz
//
//  Created by Sanyukta Adhate on 18/02/26.
//

struct CastResponse: Codable{
    let id: Int
    let cast: [CastResults]
    
    //computed property
    //https://api.themoviedb.org/3/movie/9300/credits?api_key=9a7a83ab6ed564c44e09ef91526db920
    var creditsURL: String {
        return Constants.baseURL + "\(id)/credits?api_key= \(Constants.apiKey)"
    }
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

