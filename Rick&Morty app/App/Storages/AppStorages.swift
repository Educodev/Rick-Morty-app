//
//  AppStorages.swift
//  Rick&Morty app
//
//  Created by Eduardo Herrera on 21/7/23.
//

import SwiftUI

struct AppStorages {
    static let shared = AppStorages()
    
    @AppStorage("characterName") var characterName = ""
    @AppStorage("locationName") var locationName = ""
}
