//
//  UserModel.swift
//  regotcha
//
//  Created by Chloe Nguyen on 12/2/23.
//

import Foundation
import CoreLocation

struct User: Identifiable {
    let id = UUID()
    let name: String
    let location: CLLocationCoordinate2D
    let score: Int
}
