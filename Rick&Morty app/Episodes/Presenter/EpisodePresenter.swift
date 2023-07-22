//
//  EpisodePresenter.swift
//  Rick&Morty app
//
//  Created by Eduardo Herrera on 17/7/23.
//

import SwiftUI

// Presenter class responsible for managing and providing episode data to the views.
@MainActor
public class EpisodePresenter: ObservableObject {
    
    // Array to store the loaded episodes.
    @Published var episodes = [Episode]()
    
    // Text used for filtering episodes based on the search input.
    @Published var searchText = ""
    
    // Function to load episodes based on a comma-separated string of episode IDs.
    func loadEpisodes(episodeIds: String) {
        Task {
            do {
                // Prepare the URL string to query the episodes based on the provided episode IDs.
                let urlString = K.baseURL + K.ApiEndPoints.episode + episodeIds
                
                if episodeIds.contains(",") {
                    // If there are multiple episode IDs, query and load the episodes as an array.
                    let episodesResult: [Episode] = try await ApiServices.shared.query(urlString: urlString)
                    episodes = episodesResult
                } else {
                    // If there's only one episode ID, query and load the episode as a single element in the array.
                    let episodeResult: Episode = try await ApiServices.shared.query(urlString: urlString)
                    episodes.removeAll()
                    episodes.append(episodeResult)
                }
                
            } catch let error {
                print(error)
                print(error.localizedDescription)
            }
        }
    }
    
    // Function to load new episode data when the character name changes.
    func loadNewData(_ episodeIds: String, characterName: String) {
        // Check if the character name has changed.
        if AppStorages.shared.characterName != characterName {
            // If the character name has changed, reload episodes based on the new episode IDs.
            loadEpisodes(episodeIds: episodeIds)
        }
        
        // Store the new character name in the AppStorages.
        AppStorages.shared.characterName = characterName
    }
}
