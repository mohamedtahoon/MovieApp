//
//  MovieDetailsUseCaseContract.swift
//  MovieApp
//
//  Created by Mohamed Tahoon on 12/04/2023.
//

import Foundation
protocol MovieDetailsUseCaseContract {
    func execute(id: Int, completion: @escaping Response<MovieDetails>)
}
