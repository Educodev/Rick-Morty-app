//
//  CharacterPresenter.swift
//  Rick&Morty app
//
//  Created by Eduardo Herrera on 16/7/23.
//

import SwiftUI

@MainActor
class CharacterPresenter: ObservableObject {
    @Published var characters = [Character]()
    @Published var characterFiltered = [Character]()
    @Published var episodes = [Episode]()
    @Published var searchText = ""
     
    var nextPage = ""
    var totalResults = 0
    
    // Load characters from the API
    func loadCharacters() {
        Task {
            do {
                // Create the API URL based on the nextPage value
                let urlString = nextPage.isEmpty ? K.baseURL + K.ApiEndPoints.character : nextPage
                
                // Query the API to get character data
                let call: CharacterResult = try await ApiServices.shared.query(urlString: urlString)
                
                // Update nextPage for pagination
                if let nextPage = call.info.next {
                    self.nextPage = nextPage
                }
                
                // Update totalResults and characters array with new data
                totalResults += call.results.count
                characters += call.results
                
            } catch let error {
                print(error)
                print(error.localizedDescription)
            }
        }
    }
    
    // Get episode IDs from character URLs
    func getEpisodeIds(urls: [String]) -> String {
        var ids = "/"
        for urlString in urls {
            if let url = URL(string: urlString) {
                let lastPathComponent = url.lastPathComponent
                ids.append(lastPathComponent + ",")
            }
        }
        ids.removeLast()
        return ids
    }
    
    // Filter and return characters based on search text
    func showCharacters() -> [Character] {
        if searchText.isEmpty {
            return characters
        } else {
            return characters.filter({ $0.name.contains(searchText) })
        }
    }
}
