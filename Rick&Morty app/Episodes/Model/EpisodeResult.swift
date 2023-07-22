//
//  EpisodeResult.swift
//  Rick&Morty app
//
//  Created by Eduardo Herrera on 17/7/23.
//

import Foundation

// MARK: - EpisodeResult
struct EpisodeResult: Codable {
    let info: Info
    let results: [Episode]
}

// MARK: - Info
struct InfoEpisode: Codable {
    let count, pages: Int
    let next: String
    let prev: String?
}

// MARK: - Episode
struct Episode: Codable, Identifiable {
    let id: Int
    let name, airDate, episode: String
    let characters: [String]
    let url: String
    let created: String

    enum CodingKeys: String, CodingKey {
        case id, name
        case airDate = "air_date"
        case episode, characters, url, created
    }
}

