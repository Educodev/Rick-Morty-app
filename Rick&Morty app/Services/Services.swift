//
//  Services.swift
//  Rick&Morty app
//
//  Created by Eduardo Herrera on 16/7/23.
//

import Foundation

// Class responsible for handling API requests and responses.
class ApiServices {
    
    // Singleton instance of ApiServices.
    static var shared: ApiServices {
        let apiServices = ApiServices()
        return apiServices
    }
    
    // URLSession property to handle API requests. This property can be changed in unit tests.
    var session: URLSession = URLSession.shared
    
    // Function to query the API with a given URL string and decode the response data.
    // The function returns the decoded response as a generic type conforming to Codable.
    func query<T: Codable>(urlString: String) async throws -> T {
        
        // Convert the URL string to a URL object.
        guard let url = URL(string: urlString) else {
            throw ApiErrors.urlFailure
        }
        
        do {
            // Perform an asynchronous data request using the specified URLSession.
            let (data, response) = try await session.data(from: url)
            let httpResponse = response as! HTTPURLResponse
            
            if httpResponse.statusCode == 200 {
                // Decode the response data using JSONDecoder and return the decoded result.
                let decoder = JSONDecoder()
                let result = try decoder.decode(T.self, from: data)
                return result
            } else {
                // If the HTTP response status code is not 200, throw an error with the status code.
                throw ApiErrors.httpCode(code: httpResponse.statusCode)
            }
            
        } catch let error {
            // If an error occurs during the API request, throw an error with the error description.
            throw ApiErrors.others(description: error.localizedDescription)
        }
    }
}
