//
//  FoodImageViewModel.swift
//  regotcha
//
//  Created by Chloe Nguyen on 12/1/23.
//

import Foundation

class FoodImageViewModel: ObservableObject {
    @Published var imageURL: URL?
    @Published var image: String?
    @Published var food: String?

    func fetchRandomFoodImage(completion: @escaping () -> Void) {
        guard let url = URL(string: "https://www.themealdb.com/api/json/v1/1/random.php") else { return }

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
                let foodData = try JSONDecoder().decode(MealResponse.self, from: jsonData)

                // Update UI on the main thread
                DispatchQueue.main.async {
                    if let firstMeal = foodData.meals.first {
                        self.imageURL = URL(string: firstMeal.strMealThumb)
                        self.image = firstMeal.strMealThumb
                        self.food = firstMeal.strMeal
                    } else {
                        // Handle the case where there are no meals in the response
                        self.imageURL = nil
                    }                    // Extract breed from the URL or use additional API to get breed information
                    
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
