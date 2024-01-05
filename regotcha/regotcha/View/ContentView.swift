//
//  ContentView.swift
//  regotcha
//
//  Created by Elizabeth Commisso on 11/8/23.
//

import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseFirestore
import CoreLocation
//import RecaptchaEnterprise

struct ContentView: View {
    
    @ObservedObject var countManager: CountManager
    @State private var navigateToLoseView = false
    @ObservedObject var locationManager = LocationManager()
    @State private var userLocation: CLLocationCoordinate2D?
//    @StateObject private var recaptchaViewModel = RecaptchaViewModel()
    
    var body: some View {
        
        NavigationView{
            
            ScrollView{
                
                VStack {
                    TitleView(countManager: countManager)
                    
                    if (countManager.count%14) == 1 {
                        ReenterPasswordView(countManager: countManager)
                    }
                    else if (countManager.count%14) == 2 {
                        RealCaptcha(countManager: countManager)
                    }
                    else if (countManager.count%14) == 5 {
                        FakeCaptcha(countManager: countManager)
                    }
                    
                    else if (countManager.count%14) > 2 || ((countManager.count%14) == 0 && countManager.count != 0) {
                        GameView(countManager: countManager)
                    }
                    
                    // login continous gameplay logic
//                    
//                    randomly generate a number 0 - 8 (or whatever specific numbers we have and then have a counter in count manager for logincount where we randomly assign it and execute those functions based on that)
                    
//                    if countManager.isLogin {
//                    }
                    
                    if countManager.win {
                        NavigationLink(destination: WinView(countManager:    countManager).navigationBarBackButtonHidden()) {
                            Text("DONE")
                                .font(
                                    Font.custom("Inter", size: 18)
                                        .weight(.bold)
                                )
                                .foregroundColor(.white)
                        }
                        .frame(width: 141, height: 50)
                        .background(Color(red: 0.25, green: 0.47, blue: 0.22))
                        .cornerRadius(16)
                        .shadow(color: .black.opacity(0.15), radius: 2, x: 0, y: 4)
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .inset(by: 0.5)
                                .stroke(Color(red: 0.25, green: 0.47, blue: 0.22), lineWidth: 1)
                        ).simultaneousGesture(TapGesture().onEnded{
                            register()
                            updateHighScore()
                            
                        })

                    }
                    else if countManager.answer {
                        Button(action: {
                            // Increment the count when the button is clicked
                            countManager.count += 1
                            print(countManager.count)
                            
                            // only go to the win condition when login is false
                            if !countManager.isLogin{
                                if countManager.count > 14 {
                                    countManager.win = true
                                }
                            }
                           
                        }) {
                            Text("DONE")
                                .font(
                                    Font.custom("Inter", size: 18)
                                        .weight(.bold)
                                )
                                .foregroundColor(.white)
                        }
                        .frame(width: 141, height: 50)
                        .background(Color(red: 0.25, green: 0.47, blue: 0.22))
                        .cornerRadius(16)
                        .shadow(color: .black.opacity(0.15), radius: 2, x: 0, y: 4)
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .inset(by: 0.5)
                                .stroke(Color(red: 0.25, green: 0.47, blue: 0.22), lineWidth: 1)
                        )
                    }
                    else {
                        
                        NavigationLink(destination: LoseView(countManager: countManager).navigationBarBackButtonHidden()) {
                            Text("DONE")
                                .font(
                                    Font.custom("Inter", size: 18)
                                        .weight(.bold)
                                )
                                .foregroundColor(.white)
                        }
                        .frame(width: 141, height: 50)
                        .background(Color(red: 0.25, green: 0.47, blue: 0.22))
                        .cornerRadius(16)
                        .shadow(color: .black.opacity(0.15), radius: 2, x: 0, y: 4)
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .inset(by: 0.5)
                                .stroke(Color(red: 0.25, green: 0.47, blue: 0.22), lineWidth: 1)
                        )
                        .simultaneousGesture(TapGesture().onEnded{
                            updateHighScore()
                        })
                    }
                }
            }
        }
    }
    
    func register(){
        
        let userNametoEmail = countManager.username + "@gmail.com"
        let db = Firestore.firestore()
        let usersCollection = db.collection("users")
        
        let locationManager = CLLocationManager()
        locationManager.requestWhenInUseAuthorization()
        
        Auth.auth().createUser(withEmail: userNametoEmail, password: countManager.password){ result, error in
            if let error = error {
                print("Error registering user: \(error.localizedDescription)")
            } else {
                print("User registered successfully")
                
                if let location = locationManager.location?.coordinate {
                    userLocation = location
                    let userLocation = GeoPoint(latitude: location.latitude, longitude: location.longitude)
                    addUserData(email: userNametoEmail, location: userLocation, password: countManager.password, score: countManager.count, username: countManager.username)
                }
            }
        
        }
    }
    
    func addUserData(email: String, location: GeoPoint?, password: String, score: Int, username: String) {
        let db = Firestore.firestore()
        let usersCollection = db.collection("users")

        var userData: [String: Any] = [
            "email": email,
            "password": password,
            "score": score,
            "username": username
        ]

        // Check if location is available before attempting to use it
        if let location = location {
            userData["location"] = location
        }

        // Setting the document with username as the document ID
        usersCollection.document(username).setData(userData) { error in
            if let error = error {
                print("Error adding user data: \(error.localizedDescription)")
            } else {
                print("User data added successfully")
            }
        }
    }
    
    func updateHighScore() {
        print("--------Update HighScore---------")
        
        let db = Firestore.firestore()
        let usersCollection = db.collection("users")
        
        let username = countManager.username
        
        usersCollection.document(username).getDocument { document, error in
            if let error = error {
                print("Error fetching user data: \(error.localizedDescription)")
                
            } else if let document = document, document.exists {
                
                if let storedScore = document.data()?["score"] as? Int {
                    
                    if countManager.count > storedScore {
                        
                        countManager.highScore = countManager.count
                        usersCollection.document(username).updateData(["score": countManager.count]) { error in
                            
                            if let error = error {
                                print("Error updating high score: \(error.localizedDescription)")
                            } else {
                                print("High score updated successfully")
                            }
                        }
                    } else {
                        countManager.highScore = storedScore
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView(countManager: CountManager())
}
