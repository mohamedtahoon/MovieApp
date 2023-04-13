//
//  MovieDetailsUseCase.swift
//  MovieApp
//
//  Created by Mohamed Tahoon on 12/04/2023.
//

import Foundation
class MovieDetailsUseCase: MovieDetailsUseCaseContract {
    // MARK: - Properties
    private let repo: MovieDetailsRepositoryContract
    
    // MARK: - INIT
    init(repo: MovieDetailsRepositoryContract = MovieDetailsRepository()) {
        self.repo = repo
    }
   
    // MARK: - execute
    func execute(id: Int, completion: @escaping Response<MovieDetails>) {
        repo.getMovieDetails(id: id, completion: completion)
    }
}
