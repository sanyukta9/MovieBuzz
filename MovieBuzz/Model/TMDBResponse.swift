//
//  TMDBResponse.swift
//  MovieBuzz
//
//  Created by Sanyukta Adhate on 12/02/26.
//
/*
 page : 1
 results[20]
 total_pages : 500
 total_results : 10000
 */
//must match JSON keys exactly

struct TMDBResponse: Codable {
    let page: Int
    let results: [Results]
    let total_pages: Int
    let total_results: Int
}
