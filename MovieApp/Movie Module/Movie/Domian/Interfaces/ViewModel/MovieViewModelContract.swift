//
//  MovieViewModelContract.swift
//  MovieApp
//
//  Created by Mohamed Tahoon on 12/04/2023.
//

import Foundation
typealias MovieViewModelContract = BaseViewModel & MovieViewModelContractInput & MovieViewModelContractOutput

protocol MovieViewModelContractInput {
    func getMovies() 
}

protocol MovieViewModelContractOutput {
    var movies: [Movie] { get set }
}
