//
//  MovieDetailViewModel.swift
//  MovieBuzz
//
//  Created by Sanyukta Adhate on 25/02/26.
//

import Foundation
import Combine

//protocol
//protocol MovieDetailDelegate: AnyObject {
//    func didUpdateData()
//    func didFailWithError(error: String)
//}

class MovieDetailViewModel {
//    weak var delegate: MovieDetailDelegate?
    
    //MARK: - Input
    let movieId: Int
    
    init(movieId: Int) {
        self.movieId = movieId
    }
    
    //MARK: - Read only for other classes. Only this VM modify. Property Observer. Notify to VC once updated.
//    private(set) var details: DetailsResponse?
//    private(set) var reviews: [ReviewsResults] = []
//    private(set) var casts: [CastResults] = []
//    private(set) var similar: [Results] = []
    @Published private(set) var details: DetailsResponse?
    @Published private(set) var reviews: [ReviewsResults] = []
    @Published private(set) var casts: [CastResults] = []
    @Published private(set) var similar: [Results] = []
    
    //MARK: - Computed Properties
    //0
    func detailCellViewModel() -> MovieDetailViewModelCell? {
        guard let details else { return nil }
        return MovieDetailViewModelCell(details: details)
    }
    //1
    func reviewCellViewModel() -> ReviewsViewModelCell {
        return ReviewsViewModelCell(review: reviews)
    }
    //2
    func castCellViewModel() -> CastViewModelCell {
        return CastViewModelCell(casts: casts)
    }
    //3
    func similarCellViewModel() -> SimilarViewModelCell {
        return SimilarViewModelCell(similar: similar)
    }
    
    //MARK: - MVVM Bindings. VC tells
//    var isDataUpdated : (() -> ())?
//    var isError: ((String) -> (Void))?
    
    //MARK: - Business Logic
    func fetchAll(){
        let group = DispatchGroup()
        
            //MARK: - Header Details
        
        group.enter()
            //https://api.themoviedb.org/3/movie/9300?api_key=9a7a83ab6ed564c44e09ef91526db920
        let endpoint1 = "\(Constants.baseURL)/\(movieId)?api_key=\(Constants.apiKey)"
        MovieManager.shared.fetchData(DetailsResponse.self, urlString: endpoint1) {
            [weak self] response in
            guard let self else { return }
            if let response {
                self.details = response
            }
            else {
                print("Failed to load Movie Details")
            }
            group.leave()
        }
            //MARK: - Reviews
        
        group.enter()
            //https://api.themoviedb.org/3/movie/9300/reviews?api_key=9a7a83ab6ed564c44e09ef91526db920
        let endpoint2 = "\(Constants.baseURL)/\(movieId)/reviews?api_key=\(Constants.apiKey)"
        MovieManager.shared.fetchData(ReviewsResponse.self, urlString: endpoint2) {
            [weak self] response in
            guard let self else { return }
            if let review = response?.results {
                self.reviews = review
            }
            else {
                print("Failed to load Reviews")
            }
            group.leave()
        }
            //MARK: - Cast
        
        group.enter()
            //https://api.themoviedb.org/3/movie/9300/credits?api_key=9a7a83ab6ed564c44e09ef91526db920
        let endpoint3 = "\(Constants.baseURL)/\(movieId)/credits?api_key=\(Constants.apiKey)"
        MovieManager.shared.fetchData(CastResponse.self, urlString: endpoint3) {
            [weak self] response in
            guard let self else { return }
            if let cast = response?.cast {
                self.casts = cast
            }
            else {
                print("Failed to load Casts")
            }
            group.leave()
        }
            //MARK: - Similar Movies
        
        group.enter()
            //https://api.themoviedb.org/3/movie/9300/similar?api_key=9a7a83ab6ed564c44e09ef91526db920
        let endpoint4 = "\(Constants.baseURL)/\(movieId)/similar?api_key=\(Constants.apiKey)"
        MovieManager.shared.fetchData(SimilarResponse.self, urlString: endpoint4) {
            [weak self] response in
            guard let self else { return }
            if let similar = response?.results {
                self.similar = similar
            }
            else {
                print("Failed to load Similar Movies")
            }
            group.leave()
        }
        
        group.notify(queue: .main) {
            print("All 4 APIs Called")
//            self?.delegate?.didUpdateData() // reload everything at once
        }
    }
}
