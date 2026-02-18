//
//  ReviewsResponse.swift
//  MovieBuzz
//
//  Created by Sanyukta Adhate on 18/02/26.
//

struct ReviewsResponse: Codable, Sendable {
    let id: Int
    let page: Int
    let results: [ReviewsResults]
    let total_pages: Int
    let total_results: Int
    
    //computed property
    //https://api.themoviedb.org/3/movie/9300/reviews?api_key=9a7a83ab6ed564c44e09ef91526db920
//    var reviewsURL: String {
//        return Constants.baseURL + "\(id)/reviews?api_key=\(Constants.apiKey)"
//    }
}

struct ReviewsResults: Codable, Sendable {
    let author: String
    let content: String
}
