//
//  MovieDetailsViewModel.swift
//  MovieApp
//
//  Created by Mohamed Tahoon on 12/04/2023.
//

import Foundation
class MovieDetailsViewModel: MovieDetailsViewModelContract {
    // MARK: - Properties
    private let useCase: MovieDetailsUseCaseContract
    var movie: MovieDetails?
    let id: Int?
    
    // MARK: - INIT
    init(id: Int?, useCase: MovieDetailsUseCaseContract = MovieDetailsUseCase()) {
        self.id = id
        self.useCase = useCase
    }
    
    // MARK: - getMovieDetails
    func getMovieDetails() {
        self.startLoading()
        guard let id = id else { return }
        useCase.execute(id: id) { [weak self] result in
            switch result {
            case .success(let response):
                self?.movie = response
                self?.completionHandler()
            case .failure(let error):
                self?.error = error.description
            }
            self?.stopLoading()
        }
    }
}
