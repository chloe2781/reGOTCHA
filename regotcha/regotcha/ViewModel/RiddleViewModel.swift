//
//  RiddleViewModel.swift
//  regotcha
//
//  Created by Elizabeth Commisso on 11/30/23.
//

import Foundation
import Combine

class RiddleViewModel: ObservableObject {
    @Published var riddle: String?
    @Published var answer: String?

    func fetchRandomRiddle(completion: @escaping () -> Void) {
        guard let url = URL(string: "https://riddles-api.vercel.app/random") else { return }

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
                let riddleData = try JSONDecoder().decode(RiddleData.self, from: jsonData)

                // Update UI on the main thread
                DispatchQueue.main.async {
                    self.riddle = riddleData.riddle
                    self.answer = riddleData.answer
                    
                }

            } catch {
                print("Error decoding JSON: \(error)")
            }
            
        })

        dataTask.resume()
    }
}

