//
//  FoodImageModel.swift
//  regotcha
//
//  Created by Chloe Nguyen on 12/1/23.
//

import Foundation

struct MealResponse: Codable {
    let meals: [Meal]
}

//, Identifiable
struct Meal: Codable {
    let strMeal: String
    let strMealThumb: String
}

