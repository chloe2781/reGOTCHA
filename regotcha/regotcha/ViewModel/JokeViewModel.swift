//
//  JokeViewModel.swift
//  regotcha
//
//  Created by Elizabeth Commisso on 12/2/23.
//

import Foundation


class JokeViewModel: ObservableObject {
    @Published var type: String?
    @Published var setup: String?
    @Published var delivery: String?

    func fetchRandomJoke(completion: @escaping () -> Void) {
        guard let url = URL(string: "https://v2.jokeapi.dev/joke/Pun?blacklistFlags=nsfw,religious,political,racist,sexist,explicit&type=twopart") else { return }

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
                let jokeData = try JSONDecoder().decode(JokeData.self, from: jsonData)

                // Update UI on the main thread
                DispatchQueue.main.async {
                    self.type = jokeData.type
                    self.setup = jokeData.setup
                    self.delivery = jokeData.delivery
                    
                }

            } catch {
                print("Error decoding JSON: \(error)")
            }
            
        })

        dataTask.resume()
    }
}

