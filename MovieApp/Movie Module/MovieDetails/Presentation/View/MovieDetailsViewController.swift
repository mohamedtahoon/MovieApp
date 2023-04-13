//
//  MovieDetailsViewController.swift
//  MovieApp
//
//  Created by Mohamed Tahoon on 12/04/2023.
//

import UIKit
import SDWebImage

class MovieDetailsViewController: UIViewController, Alertable{
    // MARK: - Outlet
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var yearLbl: UILabel!
    @IBOutlet weak var detailsLbl: UILabel!
    @IBOutlet weak var movieImage: UIImageView!
    
    // MARK: - Properties
    var id: Int?
    var viewModel: MovieDetailsViewModel?
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        viewModel?.getMovieDetails()
    }
    
    // MARK: - bindViewModel
    func bindViewModel() {
        viewModel = MovieDetailsViewModel(id: id)
        viewModel?.completionHandler = {
            DispatchQueue.main.async { [self] in
                guard let movie = viewModel?.movie
                else { return }
                self.nameLbl.text = movie.title
                self.yearLbl.text = movie.realeaseYear
                self.detailsLbl.text = movie.overview
                self.movieImage.sd_setImage(with: URL(string: movie.image), placeholderImage: UIImage(named:"placeHolderImage.png"))
                
            }
            
        }
        viewModel?.showError = { error in
            self.showAlert(message: error)
        }
        viewModel?.showLoading = {
            self.startLoading()
        }
        
        viewModel?.hideLoading = {
            self.stopLoading()
        }
    }
    
    // MARK: - Actions
    @IBAction func onTapBackButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}
