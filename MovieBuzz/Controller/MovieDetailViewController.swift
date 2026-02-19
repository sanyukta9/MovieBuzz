//
//  MovieDetailViewController.swift
//  MovieBuzz
//
//  Created by Sanyukta Adhate on 12/02/26.
//

import UIKit

class MovieDetailViewController: UIViewController {
    var movieId: Int!
    private var details: DetailsResponse?
    private var reviews: [ReviewsResults] = []
    private var casts: [CastResults] = []
    private var similar: [Results] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // connect table view to controller
        tableView.delegate = self
        tableView.dataSource = self
        
        //register XIBs
        tableView.register(
            UINib(nibName: "ReviewsViewCell", bundle: nil),
            forCellReuseIdentifier: "ReviewsViewCell"
        );
        tableView.register(
            UINib(nibName: "CastViewCell", bundle: nil),
            forCellReuseIdentifier: "CastViewCell"
        );
        tableView.register(
            UINib(nibName: "SimilarViewCell", bundle: nil),
            forCellReuseIdentifier: "SimilarViewCell"
        )
        
        //calling 4 APIs in parallel to load faster
        fetchAll()
    }
    
    private func fetchAll(){
        fetchDetails()
        fetchReviews()
        fetchCast()
        fetchSimilar()
    }
    
        //MARK: - Header Details
    func fetchDetails() {
        //https://api.themoviedb.org/3/movie/9300?api_key=9a7a83ab6ed564c44e09ef91526db920
        guard let movieId else { print("MovieId is nil"); return }
        let endpoint = "\(Constants.baseURL)/\(movieId)?api_key=\(Constants.apiKey)"
        MovieManager.shared.fetchData(DetailsResponse.self, urlString: endpoint) {
            [weak self] response in
            guard let self, let response else { return }
            self.details = response
            DispatchQueue.main.async {
                self.tableView.reloadSections([0], with: .none)
            }
        }
    }
        //MARK: - Reviews
    func fetchReviews() {
        //https://api.themoviedb.org/3/movie/9300/reviews?api_key=9a7a83ab6ed564c44e09ef91526db920
        guard let movieId else { print("MovieId is nil"); return }
        let endpoint = "\(Constants.baseURL)/\(movieId)/reviews?api_key=\(Constants.apiKey)"
        MovieManager.shared.fetchData(ReviewsResponse.self, urlString: endpoint) {
            [weak self] response in
            guard let self, let review = response?.results else { return }
            self.reviews = review
            DispatchQueue.main.async {
                self.tableView.reloadSections([1], with: .none)
            }
        }
    }
        //MARK: - Cast
    func fetchCast() {
        //https://api.themoviedb.org/3/movie/9300/credits?api_key=9a7a83ab6ed564c44e09ef91526db920
        guard let movieId else { print("MovieId is nil"); return }
        let endpoint = "\(Constants.baseURL)/\(movieId)/credits?api_key=\(Constants.apiKey)"
        MovieManager.shared.fetchData(CastResponse.self, urlString: endpoint) {
            [weak self] response in
            guard let self, let cast = response?.cast else { return }
            self.casts = cast
            DispatchQueue.main.async {
                self.tableView.reloadSections([2], with: .none)
            }
        }
    }
        //MARK: - Similar Movies
    func fetchSimilar() {
        //https://api.themoviedb.org/3/movie/9300/similar?api_key=9a7a83ab6ed564c44e09ef91526db920
        guard let movieId else { print("MovieId is nil"); return }
        let endpoint = "\(Constants.baseURL)/\(movieId)/similar?api_key=\(Constants.apiKey)"
        MovieManager.shared.fetchData(SimilarResponse.self, urlString: endpoint) {
            [weak self] response in
            guard let self, let similar = response?.results else { return }
            self.similar = similar
            DispatchQueue.main.async {
                self.tableView.reloadSections([3], with: .none)
            }
        }
    }
}

    //MARK: - Deleagte, Data Source, Row Height
    
extension MovieDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4 //Header, Reviews, Cast, Similar
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1 //each section has 1 row
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
            case 0:
                let cell = tableView.dequeueReusableCell(
                    withIdentifier: "MovieDetailViewCell",
                    for: indexPath
                ) as! MovieDetailViewCell
                
                if let details { cell.configure(with: details) }
                return cell
            case 1:
                let cell = tableView.dequeueReusableCell(
                    withIdentifier: "ReviewsViewCell",
                    for: indexPath
                ) as! ReviewsViewCell
                
                cell.configure(with: reviews)
                return cell
            case 2:
                let cell = tableView.dequeueReusableCell(
                    withIdentifier: "CastViewCell",
                    for: indexPath
                ) as! CastViewCell
                
                cell.configure(with: casts)
                return cell
            case 3:
                let cell = tableView.dequeueReusableCell(
                    withIdentifier: "SimilarViewCell",
                    for: indexPath
                ) as! SimilarViewCell
                
                cell.configure(with: similar)
                return cell
            default:
                return UITableViewCell()
        }
    
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
            case 0:
                return 250  // Header
            case 1:
                return 250 //Reviews
            case 2:
                return 250 //Cast
            case 3:
                return 300 //Similar movies
            default:
                return 0
        }
    }
}

