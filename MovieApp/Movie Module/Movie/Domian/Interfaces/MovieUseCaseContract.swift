//
//  MovieUseCaseContract.swift
//  MovieApp
//
//  Created by Mohamed Tahoon on 11/04/2023.
//

import Foundation
protocol MovieUseCaseContract {
    func execute(completion: @escaping Response<MovieResponse>)
    
   
}
