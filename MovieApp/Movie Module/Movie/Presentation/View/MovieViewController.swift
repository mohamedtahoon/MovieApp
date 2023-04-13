//
//  MovieViewController.swift
//  MovieApp
//
//  Created by Mohamed Tahoon on 11/04/2023.
//

import UIKit
import SDWebImage

class MovieViewController: UIViewController, Alertable {
    // MARK: - Outlet
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var movieTableView: UITableView!
    
    // MARK: - Properties
    lazy var viewModel: MovieViewModel = MovieViewModel()
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        bindViewModel()
        configureMovieTableView()
        viewModel.getMovies()
      
    }
    
    // MARK: - bindViewModel
    func bindViewModel() {
        viewModel.completionHandler = {
            DispatchQueue.main.async { [self] in
                self.movieTableView.reloadData()
            }
        }
        
        viewModel.showError = { error in
            self.showAlert(message: error)
        }
    }
}
