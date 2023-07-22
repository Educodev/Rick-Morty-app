//
//  CharacterDetaiView.swift
//  Rick&Morty app
//
//  Created by Eduardo Herrera on 17/7/23.
//

import SwiftUI

struct CharacterDetailView: View {
    @EnvironmentObject var presenter: CharacterPresenter
    @Environment(\.dismiss) var dismiss
    let character: Character
    
    var body: some View {
        // Scrollable view with character details
        ScrollView(showsIndicators: false) {
            VStack {
                // Display the character image, if available
                if let url = URL(string: character.image)  {
                    CacheAsyncImage(url:  url)
                        .frame(maxWidth: 300,
                               maxHeight: 300)
                        .overlay(Circle().stroke(LinearGradient(colors: [.randomColor(), .randomColor()], startPoint: .topLeading, endPoint: .topTrailing), lineWidth: 8))
                        .clipShape(Circle())
                        .shadow(radius: 8)
                } else {
                    // Show a placeholder image if the URL is invalid
                    Image(systemName: "photo")
                        .frame(maxWidth: 300,
                               maxHeight: 300)
                        .clipShape(Circle())
                }
                
                // Display the character name
                Text(character.name)
                    .font(.title)
                
                // Display the creation date of the character
                Text("Creado: ").fontWeight(.bold) + Text(character.created).foregroundColor(.gray)
                
                // Show the location information in a disclosure group
                DisclosureGroup("Información de ubicación") {
                    LocationInfoView(locationName: character.location.name)
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(LinearGradient(colors: [.randomColor(), .randomColor()], startPoint: .topLeading, endPoint: .topTrailing))
                .cornerRadius(32)
                .shadow(radius: 8)
                .foregroundColor(.white)
                .bold()
                .overlay(RoundedRectangle(cornerRadius: 32).stroke(Color.gray, lineWidth: 2))
                .padding(.horizontal)
                .tint(.white)
                
                Spacer()
                
                // Display the list of episodes the character appears in
                Text("Episodios")
                    .font(.title)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                
                EpisodesCarouselView(characterName: character.name, episodeIds: presenter.getEpisodeIds(urls: character.episode))
                
                Spacer(minLength: 50)
            }
        }
        .toolbar(content: {
            // Add a custom back button in the navigation bar
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    dismiss.callAsFunction()
                } label: {
                    Image(systemName: "arrowshape.backward.fill")
                        .foregroundColor(.white)
                        .padding(4)
                        .background(LinearGradient(colors: [.randomColor(), .randomColor()], startPoint: .topLeading, endPoint: .topTrailing))
                        .clipShape(Circle())
                }
            }
        })
        .navigationBarBackButtonHidden()
    }
}
