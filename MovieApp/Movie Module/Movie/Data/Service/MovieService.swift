//
//  MovieService.swift
//  MovieApp
//
//  Created by Mohamed Tahoon on 11/04/2023.
//

import Foundation
class MovieService: MovieServiceContract {
    func getMovies(completion: @escaping Response<MovieResponse>) {
        MovieAccount.getMovies.request(completion: completion)
    }
}
