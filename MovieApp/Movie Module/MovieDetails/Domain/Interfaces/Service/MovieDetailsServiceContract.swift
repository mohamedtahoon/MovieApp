//
//  MovieDetailsServiceContract.swift
//  MovieApp
//
//  Created by Mohamed Tahoon on 12/04/2023.
//

import Foundation
protocol MovieDetailsServiceContract {
    func getMovieDetails(id: Int, completion: @escaping Response<MovieDetails>)
}
