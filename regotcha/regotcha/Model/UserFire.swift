//
//  UserFire.swift
//  regotcha
//
//  Created by Gulshan Meem on 12/4/23.
//

import Foundation
import SwiftUI
import FirebaseFirestore
import FirebaseFirestoreSwift
import CoreLocation

//struct UserFire: Codable, Identifiable {
struct UserFire: Identifiable {
    var id: String?
    var email: String
    var location: CLLocationCoordinate2D
    var password: String
    var score: Int
    var username: String
}
