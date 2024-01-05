//
//  GameViewObject.swift
//  regotcha
//
//  Created by Chloe Nguyen on 11/9/23.
//

import SwiftUI
import MapKit

struct GameViewMap: View {
    
    @ObservedObject var countManager: CountManager
    @State private var userInput: String = ""
    @State private var randomCoordinate = CLLocationCoordinate2D(latitude: 0, longitude: 0)
    @State private var randomCountry: String = ""
    @State private var count: Int = 0
    
    var countryMatch: Bool {
        let answers = randomCountry.lowercased().components(separatedBy: " ")
        for word in answers {
            if userInput.lowercased().contains(word) {
                return true
            }
        }
        return false

    }
    
    var body: some View {
        VStack{
            Text("What country is this?")
                .font(Font.custom("Inter", size: 15))
                .foregroundColor(.black)
                .multilineTextAlignment(.leading)
                .padding(.top, 40)
            
//            Text("Country: \(randomCountry)")
//            Text("Count: \(count)")
            
            Spacer()
            
            MapView(coordinate: randomCoordinate)
                .onAppear {
                    updateRandomCoordinate()
                }
                .frame(height: 300)
                .padding(.horizontal, 20)

            Spacer()
            
            TextInputView(userInput: $userInput)
                .padding(.bottom, 30)
                .onChange(of: userInput) {
                    countManager.answer = countryMatch
                    countManager.loseMessage = "What kind of human doesn't know geography. I got you, robot."
                }
            
        }
    }
    
    func updateRandomCoordinate() {
        var remainingAttempts = 50
        
        
        func attemptNextCoordinate() {
            
            if remainingAttempts > 0 {
                
                generateRandomCoordinate { success in
                    if success {
                        // Successfully generated a random coordinate
                        if count != 0 && randomCountry != "Antarctica" {
                            remainingAttempts = 0
                        }else{
                            attemptNextCoordinate()
                        }
                    } else {
                        // Failed to generate a valid coordinate, reduce remaining attempts
                        remainingAttempts -= 1
                        attemptNextCoordinate()
                    }
                }
            }
        }
        
        // Start the loop
        attemptNextCoordinate()
    }
    
    func generateRandomCoordinate(completion: @escaping (Bool) -> Void) {
        let randomLat = Double.random(in: -59...83)
        let randomLon = Double.random(in: -180...180)
                
        let location = CLLocation(latitude: randomLat, longitude: randomLon)
        CLGeocoder().reverseGeocodeLocation(location) { placemarks, error in
            guard let placemark = placemarks?.first, let country = placemark.country, !country.isEmpty else {
                // Retry until a valid country is found or reach the maximum attempts
                completion(false)
                return
            }
            
            randomCoordinate = CLLocationCoordinate2D(latitude: randomLat, longitude: randomLon)
            randomCountry = country
            count = country.count
            print("Random Coordinate: \(randomCoordinate), Country: \(randomCountry)")
            
            // Update the map with the new coordinate
            completion(true)
        }
    }
}

struct MapView: UIViewRepresentable {
    var coordinate: CLLocationCoordinate2D

    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.showsUserLocation = true
        return mapView
    }

    func updateUIView(_ uiView: MKMapView, context: Context) {
        let region = MKCoordinateRegion(
            center: coordinate,
            span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10)
        )
        uiView.setRegion(region, animated: true)
        
        uiView.removeAnnotations(uiView.annotations)
        // Add a red marker
       let annotation = MKPointAnnotation()
       annotation.coordinate = coordinate
       annotation.title = ""
       uiView.addAnnotation(annotation)
    }
}

#Preview {
    GameViewMap(countManager: CountManager())
        .background(Color(red: 1, green: 0.99, blue: 0.96))
}
