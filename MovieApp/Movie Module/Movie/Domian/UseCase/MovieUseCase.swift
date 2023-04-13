//
//  MovieUseCase.swift
//  MovieApp
//
//  Created by Mohamed Tahoon on 11/04/2023.
//

import Foundation
class MovieUseCase: MovieUseCaseContract {
    // MARK: - Properties
    private let repo: MovieRepositoryContract
    
    // MARK: - INIT
    init(repo: MovieRepositoryContract = MovieRepository()) {
        self.repo = repo
    }
    
    // MARK: - execute
    func execute(completion: @escaping Response<MovieResponse>) {
        repo.getMovies(completion: completion)
    }
}
