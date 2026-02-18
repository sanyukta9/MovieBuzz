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
    var reviews: [ReviewsResults] = []
    
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
        
        fetchAllReviews()
    }
    
    
    func fetchAllReviews() {
        guard let movieId = movieId else { print("movieId is nil"); return }
        let endpoint = Constants.baseURL + "/\(movieId)/reviews?api_key=\(Constants.apiKey)"
        print("Fetching: \(endpoint)")
        
            // 1. Create a URL from a string
        guard let url = URL(string: endpoint) else { return }
        
            // 2. Create a URLSession
        let session = URLSession.shared
        
            // 3. Give URL session a task to fetch data from the Server (asynchronous)
        let task = session.dataTask(with: url) { [weak self] data, response, error in
            guard let safeData = data, error == nil else {
                print("Error loading Reviews: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            print("Raw JSON: \(String(data: safeData, encoding: .utf8) ?? "nil")")
                // 4. Parse the JSON data into swift objects
            if let parsedReviews = try? JSONDecoder().decode(ReviewsResponse.self, from: safeData) {
                DispatchQueue.main.async {
                    self?.reviews = parsedReviews.results
                    print("Reviews count: \(parsedReviews.results.count)")
                    self?.tableView.reloadData()
                }
            }
            else {
                print("Decode failed")
            }
        }
        
            // 5. Start the task ← must be OUTSIDE the closure
        task.resume()
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

