//
//  LocationResult.swift
//  Rick&Morty app
//
//  Created by Eduardo Herrera on 21/7/23.
//

import Foundation

// MARK: - LocationsResult
struct LocationsResult: Codable {
    let info: Info
    let results: [Location]
}


// MARK: - Result
struct Location: Codable, Identifiable {
    let id: Int
    let name, type, dimension: String
    let residents: [String]
    let url: String
    let created: String
}
