//
//  MovieViewController+TableView.swift
//  MovieApp
//
//  Created by Mohamed Tahoon on 12/04/2023.
//

import UIKit
extension MovieViewController: UITableViewDelegate, UITableViewDataSource {
    // MARK: - configureMovieTableView
    func configureMovieTableView() {
        
        movieTableView.delegate = self
        movieTableView.dataSource = self
        movieTableView.registerCellNib(cellClass: MovieViewCell.self)
        movieTableView.rowHeight = 200
    }
    
    // MARK: - tableview methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue() as MovieViewCell
        cell.movieTitleLbl.text = viewModel.movies[indexPath.row].title
        cell.movieYearLbl.text = viewModel.movies[indexPath.row].realeaseYear
        cell.movieImage?.sd_setImage(with: URL(string: viewModel.movies[indexPath.row].image), placeholderImage: UIImage(named:"placeHolderImage.png"))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let movieDetailsVC = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MovieDetailsViewController") as? MovieDetailsViewController
        else { return }
        movieDetailsVC.id = viewModel.movies[indexPath.row].id
        self.navigationController?.pushViewController(movieDetailsVC, animated: true)
    }
    
}
