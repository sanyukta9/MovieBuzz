//
//  MovieDetailViewController.swift
//  MovieBuzz
//
//  Created by Sanyukta Adhate on 12/02/26.
//

import UIKit

class MovieDetailViewController: UIViewController {
        //REVIEWS
    var movieId: Int!
    private var reviews: [ReviewsResults] = []
    
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
        fetchCast()
        fetchReviews()
        fetchSimilar()
    }
    
        //MARK: - Header Details
    func fetchDetails() {
        
    }
        //MARK: - Cast
    func fetchCast() {
        
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
        //MARK: - Similar Movies
    func fetchSimilar() {
        
    }


}
    
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
                
                return cell
            case 3:
                let cell = tableView.dequeueReusableCell(
                    withIdentifier: "SimilarViewCell",
                    for: indexPath
                ) as! SimilarViewCell
                
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

