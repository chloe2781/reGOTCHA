//
//  LeaderboardMapView.swift
//  regotcha
//
//  Created by Chloe Nguyen on 12/2/23.
//

import SwiftUI
import MapKit
import CoreLocation
import Firebase
import FirebaseAuth
import FirebaseFirestore

struct LeaderboardMapView: View {
    @ObservedObject var countManager: CountManager
    @State private var userLocation: CLLocationCoordinate2D?
//    let mySpecificCoordinateRegion = MKCoordinateRegion(
//        center: CLLocationCoordinate2D(latitude: 40.8100, longitude: -73.9610),
//        span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
//    )
    
    @State private var position: MapCameraPosition = MapCameraPosition.userLocation(followsHeading: true, fallback: .region(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 40.8100, longitude: -73.9610), span: MKCoordinateSpan(latitudeDelta: 5, longitudeDelta: 5))))
    
    @State private var realUsers: [UserFire] = []


    // Fake user data
    // Current user location (assumed to be available)
    // let currentUserLocation = CLLocationCoordinate2D(latitude: 40.8100, longitude: -73.9610)
    
    var body: some View {
        NavigationView{
            
            ZStack {
                Map(position: $position) {
                    
                    // Add annotations for fake users
                    ForEach(realUsers) { user in
                        Annotation("\(user.username)\n\(user.score)", coordinate: user.location) {
                            ZStack {
                                Circle()
                                    .fill(Color.red)
                                    .frame(width: 30, height: 30)
                                Text(user.username.prefix(1))
                                    .foregroundColor(.white)
                                    .font(.headline)
                            }.font(.title)
                        }
                    }
                    
                    // Add annotation for the current user
                    Annotation("You\n\(countManager.count)", coordinate: userLocation ?? CLLocationCoordinate2D(latitude: 40.8100, longitude: -73.9610)) {
                        ZStack {
                            Circle()
                                .fill(Color.green)
                                .frame(width: 30, height: 30)
                            Image(systemName: "person.fill")
                                .foregroundColor(.white)
                                .padding(5)
                        }
                    }
                }
                .mapStyle(.standard(elevation: .realistic))
                
                VStack {
                    Text("Leaderboard")
                        .font(.system(size: 34, weight: .black))
                        .foregroundColor(.black)
                    
                    Spacer()
                    
                    NavigationLink(destination: LoginView(countManager: countManager).navigationBarBackButtonHidden()) {
                        
                        VStack {
                            Image("logo")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 50, height: 50)
                            
                            
                            Text("reTRY")
                                .font(Font.custom("Inter", size: 30))
                                .foregroundColor(.black)
                                .padding(.bottom, 20)
                        }
                        
                    }.simultaneousGesture(TapGesture().onEnded {
                        countManager.resetCount()
                    })
                }
                .padding(.top, 20)
            }
            .onAppear {
                fetchUserLocation()
                getData()

            }
        }
    }
    
    private func fetchUserLocation() {
        let locationManager = CLLocationManager()
        locationManager.requestWhenInUseAuthorization()

        if let location = locationManager.location?.coordinate {
            userLocation = location
            position = MapCameraPosition.region(MKCoordinateRegion(center: location, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)))

        } else {
//            let randomLat = Double.random(in: -59...83)
//            let randomLon = Double.random(in: -180...180)
            // If user location is not available, provide a default location
            
            userLocation = CLLocationCoordinate2D(latitude: 40.8100, longitude: -73.9610)

        }
    }
    
    private func getData() {
            print("getData was called!!")
            let db = Firestore.firestore()
            db.collection("users").getDocuments { snapshot, error in
                if error == nil {
                    // no error
                    if let snapshot = snapshot {
                        DispatchQueue.main.async {
                            
                        let users = snapshot.documents.map { d in
                            let geoPoint = d["location"] as? GeoPoint
                            let userCoord = CLLocationCoordinate2D(latitude: geoPoint!.latitude, longitude: geoPoint!.longitude)
                            
                            return UserFire(id: d["id"] as? String,
                                            email: d["email"] as! String,
                                            location: userCoord,
                                            password: d["password"] as! String,
                                            score: d["score"] as! Int,
                                            username: d["username"] as! String)
                        }

                        // Update the @State variable on the main thread
                        self.realUsers = users
                           // print (self.realUsers)
                           // print ("----------------------------")
                            //print (fakeUsers)
                        
                        }
                    }
                    
                } else {
                    // handle error
                    print("Error fetching data: \(error!.localizedDescription)")

                }
            }
        }
}

#Preview {
    LeaderboardMapView(countManager: CountManager())
}
