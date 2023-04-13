//
//  MovieServiceContract.swift
//  MovieApp
//
//  Created by Mohamed Tahoon on 11/04/2023.
//

import Foundation
protocol MovieServiceContract {
    func getMovies(completion: @escaping Response<MovieResponse>)
}
