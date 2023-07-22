//
//  Rick_Morty_appApp.swift
//  Rick&Morty app
//
//  Created by Eduardo Herrera on 10/7/23.
//

import SwiftUI

@main
struct Rick_Morty_appApp: App {

    //
    @StateObject private var characterPresenter = CharacterPresenter()
    @StateObject private var episodePresenter = EpisodePresenter()
    @StateObject private var locationPresenter = LocationPresenter()
   
    var body: some Scene {
        WindowGroup {
           CharacterListView()
                .environmentObject(characterPresenter)
                .environmentObject(episodePresenter)
                .environmentObject(locationPresenter)
                .fontDesign(.rounded)
        }
    }
}
