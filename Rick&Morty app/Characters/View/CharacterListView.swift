//
//  CharacterListView.swift
//  Rick&Morty app
//
//  Created by Eduardo Herrera on 16/7/23.
//

import SwiftUI

struct CharacterListView: View {
    @EnvironmentObject var presenter: CharacterPresenter
    @State var offsetToShow = 0
    
    var body: some View {
        // Show a loading indicator if characters are empty
        if presenter.characters.isEmpty {
            ProgressView()
                .onAppear {
                    presenter.loadCharacters()
                }
        }
        
        GeometryReader { geometry in
            NavigationStack {
                VStack {
                    ScrollViewReader { reader in
                        ZStack(alignment: .bottomTrailing) {
                            List(presenter.showCharacters()) { character in
                                NavigationLink(destination: CharacterDetailView(character: character)) {
                                    listRow(character, size: geometry.size)
                                }
                                .task {
                                    print(character.id)
                                    if character.id == presenter.totalResults {
                                        presenter.loadCharacters()
                                    }
                                    offsetToShow = character.id
                                }
                            }
                            .searchable(text: $presenter.searchText)
                            .navigationTitle("Personajes")
                            .listStyle(.plain)
                            
                            // Show the "scroll to top" button when offsetToShow is greater than 20
                            if offsetToShow > 20 {
                                Button {
                                    withAnimation {
                                        reader.scrollTo(1, anchor: .top)
                                    }
                                } label: {
                                    Image(systemName: "chevron.up")
                                        .foregroundColor(.white)
                                        .padding()
                                        .background(LinearGradient(colors: [.randomColor(), .randomColor()], startPoint: .topLeading, endPoint: .topTrailing))
                                        .clipShape(Circle())
                                        .padding()
                                }
                            }
                        }
                    }
                }
            }
            .tint(.randomColor())
        }
    }
    
    // Creates a row view for each character in the list
    private func listRow(_ character: Character, size: CGSize) -> some View {
        return HStack {
            // Load the character image from the URL using the CacheAsyncImage component
            if let url = URL(string: character.image)  {
                CacheAsyncImage(url: url)
                    .frame(maxWidth: size.width/3,
                           maxHeight: .infinity)
                    .cornerRadius(8)
                    .clipped()
            } else {
                // Show a placeholder image if the URL is invalid
                Image(systemName: "photo")
                    .frame(maxWidth: size.width/3,
                           maxHeight: .infinity)
                    .cornerRadius(8)
            }
            
            VStack(alignment: .leading, spacing: 8) {
                Text(character.name)
                    .font(.system(size: 20))
                    .fontWeight(.black)
                    .lineLimit(2)
                
                HStack {
                    // Show a color indicator based on the character's status
                    colorIndicator(status: character.status)
                    Text(character.status.rawValue + " - " + character.species)
                }
                
                VStack(alignment: .leading, spacing: 0) {
                    Text("Última ubicación:").foregroundColor(.gray).font(.system(size: 15))
                    Text(character.location.name)
                        .lineLimit(1)
                }
                
                VStack(alignment: .leading, spacing: 0) {
                    Text("Genero: ")+Text(character.gender).foregroundColor(.gray).font(.system(size: 15))
                }
            }
        }
    }
    
    // Returns a color indicator view based on the character's status
    private func colorIndicator(status: Status) -> some View {
        var color: Color
        
        switch status {
        case .dead:
            color = Color.red
        case .alive:
            color = Color.green
        case .unknown:
            color = Color.gray
        }
        
        return color.frame(width: 10, height: 10).clipShape(Circle())
    }
}

/*
 private func remoteImage(urlString: String) -> some View {
 let url = URL(string: urlString)
 
 return AsyncImage(url: url) { phase in
 switch phase {
 case .empty:
 ProgressView()
 case .success(let image):
 image
 .resizable()
 .aspectRatio(contentMode: .fill)
 case .failure:
 Image(systemName: "photo")
 @unknown default:
 Image(systemName: "photo")
 }
 }
 }
 }*/
