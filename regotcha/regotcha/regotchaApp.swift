//
//  regotchaApp.swift
//  regotcha
//
//  Created by Elizabeth Commisso on 11/8/23.
//

import SwiftUI
import Firebase

@main
struct regotchaApp: App {
    
    init(){
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            WelcomeView()
        }
    }
}
