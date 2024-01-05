//
//  LoseView.swift
//  regotcha
//
//  Created by Elizabeth Commisso on 11/18/23.
//

import SwiftUI
import Firebase
import FirebaseFirestore

struct LoseView: View {
    @ObservedObject var countManager: CountManager 
//    let customMessage: String?
    
    var body: some View {
        NavigationView{
            
            VStack {
                
//                Image("logo")
//                    .resizable()
//                    .aspectRatio(contentMode: .fit)
//                    .frame(width: 50, height: 50)
////                    .padding(.top, -200)
//                    .padding(.bottom, 10)
                
                Text("reGOTCHA")
                    .font(Font.custom("Inter", size: 30))
                    .foregroundColor(.black)
//                    .padding(.top, -200)
                    .padding(10)
                
                //            Spacer().frame(height: 50)
                
                Text("FAILED!")
                    .font(.system(size: 34, weight: .bold))
                    .foregroundColor(Color(red: 234/255, green: 51/255, blue: 35/255))
                    .padding(.bottom, 15)
                
                Text(countManager.loseMessage)
                    .font(.system(size: 34, weight: .bold))
                    .foregroundColor(Color(red: 234/255, green: 51/255, blue: 35/255))
                    .multilineTextAlignment(.center)
                    .minimumScaleFactor(0.5) // Adjust the minimum scale factor as needed
                    .lineLimit(2) // Limit the number of lines to control text wrapping
                    .padding(.horizontal, 30)
                
//                Text("Go away.")
//                    .font(.system(size: 34, weight: .bold))
//                    .foregroundColor(Color(red: 234/255, green: 51/255, blue: 35/255))
                
                Text("🤖")
                    .font(Font.custom("Inter", size: 34))
                    .foregroundColor(.black)
                    .padding(.top, 10)
                    .padding(.bottom, 30)
                
                // add link to display leaderboard
                NavigationLink(destination: LeaderboardMapView(countManager: countManager).navigationBarBackButtonHidden()) {
                    
                    
                    Text("Leaderboard")
                        .font(Font.custom("Inter", size: 30))
                        .foregroundColor(.black)
                        .padding(.vertical, 12)
                        .padding(.horizontal, 20)
                        .background(
                            RoundedRectangle(cornerRadius: 16)
                                .fill(Color(red: 234/255, green: 51/255, blue: 35/255))
                        )
                        .padding()
                }

                
                
                //button to nav to start -- content view 1st page
                NavigationLink(destination: WelcomeView(countManager: countManager).navigationBarBackButtonHidden()) {
                    
                    
                    VStack {
                        Image("logo")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 50, height: 50)
                        
                        
                        Text("reTRY")
                            .font(Font.custom("Inter", size: 30))
                            .foregroundColor(.black)
                            .padding(.bottom, 50)
                    }
                    
                }.simultaneousGesture(TapGesture().onEnded {
                    countManager.resetCount()
                })
                
                
                // need to connect to firebase to get scores
                //putting in temp values for now
                Text("VeriScore: \(countManager.count)")
                    .font(Font.custom("Inter", size: 34))
                    .foregroundColor(Color(red: 234/255, green: 51/255, blue: 35/255))
                    .padding(.bottom, 10)
                
                // HERE, CONNECT WITH HIGH SCORE FROM DB. right now put at 11 which is our max based on the counter
                Text("VeriHigh: \(countManager.highScore)")
                    .font(Font.custom("Inter", size: 25))
                    .foregroundColor(Color(red: 64/255, green: 121/255, blue: 57/255))
                    .padding(.bottom, 15)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity) // make VStack take up the entire screen so we can color whole screen
            .background(Color(red: 224/255, green: 196/255, blue: 194/255))
            .edgesIgnoringSafeArea(.all)
        }
        
    }
}

#Preview {
    LoseView(countManager: CountManager())
}
