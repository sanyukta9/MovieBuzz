//
//  ReviewsResponse.swift
//  MovieBuzz
//
//  Created by Sanyukta Adhate on 18/02/26.
//

struct ReviewsResponse: Codable {
    let id: Int
    let page: Int
    let results: [ReviewsResults]
    let total_pages: Int
    let total_results: Int
}

struct ReviewsResults: Codable {
    let author: String
    let content: String
}
