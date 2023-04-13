//
//  MovieDetailsService.swift
//  MovieApp
//
//  Created by Mohamed Tahoon on 12/04/2023.
//

import Foundation
class MovieDetailsService: MovieDetailsServiceContract {
    func getMovieDetails(id: Int,completion: @escaping Response<MovieDetails>) {
       return MovieAccount.getMovieDetails(id: id).request(completion: completion)
    }
}
