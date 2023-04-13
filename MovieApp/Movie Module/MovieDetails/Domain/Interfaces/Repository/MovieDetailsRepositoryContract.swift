//
//  MovieDetailsReppositoryContract.swift
//  MovieApp
//
//  Created by Mohamed Tahoon on 12/04/2023.
//

import Foundation
protocol MovieDetailsRepositoryContract {
    func getMovieDetails(id: Int, completion: @escaping Response<MovieDetails>)
}
