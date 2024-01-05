//
//  WelcomeView.swift
//  regotcha
//
//  Created by Elizabeth Commisso on 11/8/23.
//

import SwiftUI

struct WelcomeView: View {
    @ObservedObject var countManager: CountManager = CountManager()
    @ObservedObject var networkManager = NetworkManager()
    @StateObject private var locationManager = LocationManager()
    
    var body: some View {
        NavigationView{
            
            VStack {
                Image("logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 55, height: 55)
                
                Text("reGOTCHA")
                    .font(Font.custom("Inter", size: 34))
                    .foregroundColor(.black)
                    .padding(.bottom, 30)
                if networkManager.isNetworkReachable {
                    
                    Text("New here?")
                        .font(Font.custom("Inter", size: 15))
                        .foregroundColor(.gray)
                        .padding(.bottom, -20)
                    
                    NavigationLink(destination: ContentView(countManager: countManager).navigationBarBackButtonHidden()) {
                        Text("SIGN UP")
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
                    .padding()
                    
                    Text("Already joined?")
                        .font(Font.custom("Inter", size: 15))
                        .foregroundColor(.gray)
                        .padding(.bottom, -20)
                    
                    NavigationLink(destination: LoginView(countManager: countManager).navigationBarBackButtonHidden()) {
                        Text("LOG IN")
                            .font(
                                Font.custom("Inter", size: 18)
                                    .weight(.bold)
                            )
                            .foregroundColor(.white)
                    }
                    .frame(width: 141, height: 50)
                    .background(Color(red: 0.22, green: 0.35, blue: 0.47))
                    .cornerRadius(16)
                    .shadow(color: .black.opacity(0.15), radius: 2, x: 0, y: 4)
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .inset(by: 0.5)
                            .stroke(Color(red: 0.25, green: 0.47, blue: 0.22), lineWidth: 1)
                    )
                    .padding()
                    .simultaneousGesture(TapGesture().onEnded{
                        countManager.isLogin = true
                    })
                } else {
                    // Show a message or alert when there is no internet connection
                    Text("No Internet Connection")
                        .foregroundColor(.red)
                        .padding()
                    
                    Button(action:  {
                        networkManager.startMonitoring() // Retry to check internet connection
                    })
                    {
                        Text("Retry")
                            .font(
                                Font.custom("Inter", size: 18)
                                    .weight(.bold)
                            )
                            .foregroundColor(.white)
                        
                    }
                        .padding()
                        .frame(width: 141, height: 50)
                        .background(Color(red: 0.25, green: 0.47, blue: 0.22))
                        .cornerRadius(16)
                        .shadow(color: .black.opacity(0.15), radius: 2, x: 0, y: 4)
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .inset(by: 0.5)
                                .stroke(Color(red: 0.25, green: 0.47, blue: 0.22), lineWidth: 1)
                        )
                        .padding()
                }
            }.alert(isPresented: .constant(!networkManager.isNetworkReachable)) {
                Alert(
                    title: Text("No Internet Connection"),
                    message: Text("Please check your internet connection and try again."),
                    dismissButton: .default(Text("OK"))
                )
            }
        }.onAppear {
            // Optionally, you can request the location when the view appears
            locationManager.requestLocation()
        }
    }
}

#Preview {
    WelcomeView()
}
