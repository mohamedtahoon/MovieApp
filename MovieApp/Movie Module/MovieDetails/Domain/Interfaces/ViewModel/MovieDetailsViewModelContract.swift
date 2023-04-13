//
//  MovieDetailsViewModelContract.swift
//  MovieApp
//
//  Created by Mohamed Tahoon on 12/04/2023.
//

import Foundation
typealias MovieDetailsViewModelContract = BaseViewModel & MovieDetailsViewModelContractInput & MovieDetailsViewModelContractOutput

protocol MovieDetailsViewModelContractInput {
    func getMovieDetails()
}

protocol MovieDetailsViewModelContractOutput {
    var movie: MovieDetails? { get set }
   
}
