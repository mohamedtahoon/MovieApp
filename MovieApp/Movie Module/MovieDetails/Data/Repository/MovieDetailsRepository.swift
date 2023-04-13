//
//  MovieDetailsRepository.swift
//  MovieApp
//
//  Created by Mohamed Tahoon on 12/04/2023.
//

import Foundation
class MovieDetailsRepository: MovieDetailsRepositoryContract {
    
    // MARK: - Properties
    private let service: MovieDetailsServiceContract
    
    // MARK: - INIT
    
    init(service: MovieDetailsServiceContract = MovieDetailsService()) {
        self.service = service
    }
    
    // MARK: - getMovieDetails
    func getMovieDetails(id: Int, completion: @escaping Response<MovieDetails>) {
        service.getMovieDetails(id: id, completion: completion)
    }
}
