//
//  CharacterModel.swift
//  Rick&Morty app
//
//  Created by Eduardo Herrera on 16/7/23.
//

import Foundation

// MARK: - CharacterModel
struct CharacterResult: Codable {
    let info: Info
    let results: [Character]
}

// MARK: - Result
struct Character: Codable, Identifiable {
    let id: Int
    let name, species, type, gender, image, url, created: String
    let status: Status
    let origin, location: LocationCharacter
    let episode: [String]
}

// MARK: - Location
struct LocationCharacter: Codable {
    let name: String
    let url: String
}


enum Status: String, Codable {
    case alive = "Alive"
    case dead = "Dead"
    case unknown = "unknown"
}

