//
//  MovieDetailViewController.swift
//  MovieBuzz
//
//  Created by Sanyukta Adhate on 12/02/26.
//

import UIKit

class MovieDetailViewController: UIViewController {
    var viewModel: MovieDetailViewModel!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupTableView()
        setupBindings()
        viewModel.fetchAll()
    }
    
    private func setupTableView() {
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
    }
    
    private func setupBindings() {
        viewModel.isDataUpdated = { [weak self] in
            self?.tableView.reloadData()
        }
        viewModel.isError = { message in
            print("Error: \(message)")
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
                
                    //get movie for ith row
                if let vmDetails = viewModel.detailCellViewModel() {
                        //pass movie data to cell
                    cell.configure(with: vmDetails)
                }
                return cell
            case 1:
                let cell = tableView.dequeueReusableCell(
                    withIdentifier: "ReviewsViewCell",
                    for: indexPath
                ) as! ReviewsViewCell
                
                cell.configure(with: viewModel.reviewCellViewModel()) //instead of array passing VM
                return cell
            case 2:
                let cell = tableView.dequeueReusableCell(
                    withIdentifier: "CastViewCell",
                    for: indexPath
                ) as! CastViewCell
                
                cell.configure(with: viewModel.castCellViewModel()) //instead of array passing VM
                return cell
            case 3:
                let cell = tableView.dequeueReusableCell(
                    withIdentifier: "SimilarViewCell",
                    for: indexPath
                ) as! SimilarViewCell
                
                cell.configure(with: viewModel.similarCellViewModel()) //instead of array passing VM
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

