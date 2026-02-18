//
//  TMDBResponse.swift
//  MovieBuzz
//
//  Created by Sanyukta Adhate on 12/02/26.
//
//codable: convert JSON <-> Swift automatically.
//must match JSON keys exactly

/*
 page : 1
 results[20]
 total_pages : 500
 total_results : 10000
 */

struct TMDBResponse: Codable {
    let page: Int
    let results: [Results]
    let total_pages: Int
    let total_results: Int
}

/*
 {
 "page": 1,
 "results": [
 {
 "adult": false,
 "backdrop_path": "/44immBwzhDVyjn87b3x3l9mlhAD.jpg",
 "id": 934433,
 "title": "Scream VI",
 "original_language": "en",
 "original_title": "Scream VI",
 "overview": "Following the latest Ghostface killings, the four survivors leave Woodsboro behind and start a fresh chapter.",
 "poster_path": "/wDWwtvkRRlgTiUr6TyLSMX8FCuZ.jpg",
 "media_type": "movie",
 "genre_ids": [
 27,
 9648,
 53
 ],
 "popularity": 609.941,
 "release_date": "2023-03-08",
 "video": false,
 "vote_average": 7.374,
 "vote_count": 684
 }
 ],
 "total_pages": 1000,
 "total_results": 20000
 }
 */

struct Results: Codable {
    let id: Int
    let title: String
    let overview: String
    let poster_path: String?
    let release_date: String
        
    //computed property
    //https://image.tmdb.org/t/p/w500/wDWwtvkRRlgTiUr6TyLSMX8FCuZ.jpg
    var posterURL: String? {
        guard let posterPath = poster_path else { return nil}
        return Constants.posterImageURL + posterPath
    }
        //computed property
        //https://api.themoviedb.org/3/movie/9300/similar?api_key=9a7a83ab6ed564c44e09ef91526db920
    var similarURL: String {
        return Constants.baseURL + "/\(id)/similar?api_key=\(Constants.apiKey)"
    }
}
