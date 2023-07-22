//
//  EpisodeCarouselView.swift
//  Rick&Morty app
//
//  Created by Eduardo Herrera on 21/7/23.
//

import SwiftUI

// View that displays a horizontal carousel of episodes for a specific character.
struct EpisodesCarouselView: View {
    
    // Access the EpisodePresenter through the environment.
    @EnvironmentObject var presenter: EpisodePresenter
    
    // Character name used for data fetching and identification.
    let characterName: String
    
    // Comma-separated string containing the episode IDs for the character.
    let episodeIds: String
    
    var body: some View {
        // Show a ProgressView if the episodes haven't been loaded yet.
        if presenter.episodes.isEmpty {
            ProgressView()
                .task {
                    // Load episodes when the view appears.
                    presenter.loadEpisodes(episodeIds: episodeIds)
                }
        }
        
        // Horizontal ScrollView to display the episodes in a carousel format.
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                // Iterate through each episode in the presenter.
                ForEach(presenter.episodes) { episode in
                    VStack(alignment: .leading, spacing: 4) {
                        // Display the episode name.
                        Text(episode.name)
                            .foregroundColor(.white)
                            .fontWeight(.black)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        // Display the episode air date and creation date.
                        Text(episode.airDate)
                        Text(episode.created)
                            .font(.callout)
                        
                        Spacer()
                        
                        // Display the episode code.
                        Text(episode.episode)
                            .fontWeight(.light)
                        
                    }
                    .padding(8)
                    .frame(width: 200, height: 150)
                    .background(background()) // Apply custom background to each episode view.
                    .cornerRadius(8)
                }
            }
            .padding(.horizontal)
        }
        .onAppear {
            // Load new episode data when the view appears or when characterName changes.
            presenter.loadNewData(episodeIds, characterName: characterName)
        }
    }
    
    // Custom background for each episode view, composed of a random color and gradient.
    private func background() -> some View {
        ZStack {
            Color.randomColor() // Generate a random color for the background.
            Color.white.opacity(0.8) // Add opacity to the white color for a translucent effect.
            LinearGradient(colors: [.black.opacity(0.5), .clear], startPoint: .top, endPoint: .bottom)
            // Apply a gradient that fades from top to bottom, creating a vignette effect.
        }
    }
}
