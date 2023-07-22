//
//  InfoResponse.swift
//  Rick&Morty app
//
//  Created by Eduardo Herrera on 21/7/23.
//

import Foundation
// MARK: - Info
struct Info: Codable {
    let count, pages: Int
    let next: String?
    let prev: String?
}
