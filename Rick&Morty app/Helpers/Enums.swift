//
//  Enums.swift
//  Rick&Morty app
//
//  Created by Eduardo Herrera on 16/7/23.
//

import Foundation



enum ApiErrors: Error {
    case requestFailure
    case urlFailure
    case httpCode(code: Int)
    case others(description: String)
}

enum ModelError: Error {
    case noEpisodes
}
