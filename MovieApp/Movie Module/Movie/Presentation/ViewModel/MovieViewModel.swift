//
//  MovieViewModel.swift
//  MovieApp
//
//  Created by Mohamed Tahoon on 11/04/2023.
//

import Foundation
class MovieViewModel: MovieViewModelContract {
    // MARK: - Properties
    private let useCase: MovieUseCaseContract
    var movies: [Movie] = []
    
    // MARK: - INIT
    init(useCase: MovieUseCaseContract = MovieUseCase()) {
        self.useCase = useCase
    }
    
    // MARK: - getMovies
    func getMovies() {
        self.startLoading()
        useCase.execute() { [weak self] result in
            switch result {
            case .success(let response):
                self?.movies = response.results
                self?.completionHandler()
                
            case .failure(let error):
                self?.error = error.description
            }
            self?.stopLoading()
        }
    }
}
