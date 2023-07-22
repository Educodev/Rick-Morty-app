//
//  LocationPresenter.swift
//  Rick&Morty app
//
//  Created by Eduardo Herrera on 21/7/23.
//

import SwiftUI

@MainActor
public class LocationPresenter: ObservableObject {
    
    @Published var locations = [Location]()
    
    // Load locations based on the given location name
    func loadLocation(_ locationName: String) {
        Task {
            do {
                let urlString = K.baseURL+K.ApiEndPoints.location+"/?name=\(locationName)"
                let cleanedURLString = urlString.replacingOccurrences(of: " ", with: "%20")
                print(cleanedURLString)
                
                let locationsResult: LocationsResult = try await ApiServices.shared.query(urlString: cleanedURLString)
                locations = locationsResult.results
                
            } catch let error {
                print(error)
                print(error.localizedDescription)
            }

        }
    }
    
    // Load new data if the location name has changed
    func loadNewData(_ locationName: String) {
        if AppStorages.shared.locationName != locationName {
            loadLocation(locationName)
        }
        
        AppStorages.shared.locationName = locationName
    }
    
}
