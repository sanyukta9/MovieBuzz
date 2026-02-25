//
//  MovieDetailViewModel.swift
//  MovieBuzz
//
//  Created by Sanyukta Adhate on 25/02/26.
//
import Foundation

class MovieDetailViewModel {
    
    //MARK: - Input
    let movieId: Int
    
    init(movieId: Int) {
        self.movieId = movieId
    }
    
    //MARK: - Read only for other classes. Only this VM modify. Property Observer. Notify to VC once updated.
    private(set) var details: DetailsResponse?
    private(set) var reviews: [ReviewsResults] = []
    private(set) var casts: [CastResults] = []
    private(set) var similar: [Results] = []
    
    //MARK: - MVVM Bindings. VC tells
    var isDataUpdated : (() -> ())?
    var isError: ((String) -> (Void))?
    
    //MARK: - Computed Properties
    var reviewsCount: Int  { reviews.count }
    var castsCount: Int { casts.count }
    var similarCounts: Int { similar.count }
    func reviewsAtIndex(at index: Int) -> ReviewsResults { reviews[index] }
    func castsAtIndex(at index: Int) -> CastResults { casts[index] }
    func similarAtIndex(at index: Int) -> Results { similar[index] }
    
    //MARK: - Business Logic
    func fetchAll(){
        let group = DispatchGroup()
        
            //MARK: - Header Details
        
        group.enter()
            //https://api.themoviedb.org/3/movie/9300?api_key=9a7a83ab6ed564c44e09ef91526db920
        let endpoint1 = "\(Constants.baseURL)/\(movieId)?api_key=\(Constants.apiKey)"
        MovieManager.shared.fetchData(DetailsResponse.self, urlString: endpoint1) {
            [weak self] response in
            guard let self, let response else { return }
            self.details = response
            group.leave()
        }
            //MARK: - Reviews
        
        group.enter()
            //https://api.themoviedb.org/3/movie/9300/reviews?api_key=9a7a83ab6ed564c44e09ef91526db920
        let endpoint2 = "\(Constants.baseURL)/\(movieId)/reviews?api_key=\(Constants.apiKey)"
        MovieManager.shared.fetchData(ReviewsResponse.self, urlString: endpoint2) {
            [weak self] response in
            guard let self, let review = response?.results else { return }
            self.reviews = review
            group.leave()
        }
            //MARK: - Cast
        
        group.enter()
            //https://api.themoviedb.org/3/movie/9300/credits?api_key=9a7a83ab6ed564c44e09ef91526db920
        let endpoint3 = "\(Constants.baseURL)/\(movieId)/credits?api_key=\(Constants.apiKey)"
        MovieManager.shared.fetchData(CastResponse.self, urlString: endpoint3) {
            [weak self] response in
            guard let self, let cast = response?.cast else { return }
            self.casts = cast
            group.leave()
        }
            //MARK: - Similar Movies
        
        group.enter()
            //https://api.themoviedb.org/3/movie/9300/similar?api_key=9a7a83ab6ed564c44e09ef91526db920
        let endpoint4 = "\(Constants.baseURL)/\(movieId)/similar?api_key=\(Constants.apiKey)"
        MovieManager.shared.fetchData(SimilarResponse.self, urlString: endpoint4) {
            [weak self] response in
            guard let self, let similar = response?.results else { return }
            self.similar = similar
            group.leave()
        }
        
        group.notify(queue: .main) { [weak self] in
            print("All 4 APIs Called")
            self?.isDataUpdated?() // reload everything at once
        }
    }
}
