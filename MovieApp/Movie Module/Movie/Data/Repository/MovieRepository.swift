//
//  MovieRepository.swift
//  MovieApp
//
//  Created by Mohamed Tahoon on 11/04/2023.
//

import Foundation
class MovieRepository: MovieRepositoryContract {
    
    // MARK: - Properties
    private let service: MovieServiceContract
    
    // MARK: - INIT
    init(service: MovieServiceContract = MovieService()) {
        self.service = service
    }
    
    func getMovies(completion: @escaping Response<MovieResponse>) {
        service.getMovies(completion: completion)
    }
}
