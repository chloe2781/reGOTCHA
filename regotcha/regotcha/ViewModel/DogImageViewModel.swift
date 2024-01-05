//
//  DogImageViewModel.swift
//  regotcha
//
//  Created by Elizabeth Commisso on 11/16/23.
//

import Foundation

class DogImageViewModel: ObservableObject {
    @Published var imageURL: URL?
    @Published var breed: String?

    func fetchRandomDogImage(completion: @escaping () -> Void) {
        guard let url = URL(string: "https://dog.ceo/api/breeds/image/random") else { return }

        let request = URLRequest(url: url) // Create a URLRequest from the URL
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
            if let error = error {
                print(error)
                return
            }

            // ensure there is data returned from this HTTP response
            guard let jsonData = data else {
                print("No data")
                return
            }
            
            // parse the data
            do {
                let dogData = try JSONDecoder().decode(DogData.self, from: jsonData)

                // Update UI on the main thread
                DispatchQueue.main.async {
                    self.imageURL = URL(string: dogData.message)
                    // Extract breed from the URL or use additional API to get breed information
                    self.breed = self.extractBreed(from: dogData.message)
                }
            } catch {
                print("Error decoding JSON: \(error)")
            }
            
        })
        
        dataTask.resume()
    }
    
    // Extract breed from the URL (you might need to adjust this based on the actual URL format)
    private func extractBreed(from urlString: String) -> String {
        let components = urlString.components(separatedBy: "/")
        if components.count >= 5 {
            let component = components[4].components(separatedBy: "-")
            let reversedComp = component.reversed()
            let formattedBreed = reversedComp.joined(separator: " ")

            return formattedBreed
        } else {
            return "Unknown"
        }
    }
}
