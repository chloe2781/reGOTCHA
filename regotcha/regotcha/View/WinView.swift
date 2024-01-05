//
//  WinView.swift
//  regotcha
//
//  Created by Elizabeth Commisso on 11/18/23.
//

import SwiftUI

struct WinView: View {
    @ObservedObject var countManager: CountManager
    var body: some View {
        NavigationView{
            
            VStack {
                
                Image("logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50, height: 50)
//                    .padding(.top, -200)
                    .padding(.bottom, 10)
                
                Text("reGOTCHA")
                    .font(Font.custom("Inter", size: 30))
                    .foregroundColor(.black)
//                    .padding(.top, -200)
                    .padding(.bottom, 100)
                
                //            Spacer().frame(height: 50)
                
                Text("CONGRATS!")
                    .font(.system(size: 34, weight: .bold))
                    .foregroundColor(Color(red: 64/255, green: 121/255, blue: 35/255))
                    .padding(.bottom, 15)
                
                Text("You're human.")
                    .font(.system(size: 34, weight: .bold))
                    .foregroundColor(Color(red: 64/255, green: 121/255, blue: 35/255))
                    .padding(.bottom, 30)
                
                
                // need to connect to firebase to get scores
                //putting in temp values for now
                Text("VERIHIGH: \(countManager.count)")
                    .font(.system(size: 30))
                    .foregroundColor(Color(red: 64/255, green: 121/255, blue: 57/255))
                    .padding(.bottom, 50)
                
                
                // add link to display leaderboard
                NavigationLink(destination: LeaderboardMapView(countManager: countManager).navigationBarBackButtonHidden()) {
                    
                    
                    Text("Leaderboard")
                        .font(Font.custom("Inter", size: 30))
                        .foregroundColor(.black)
                        .padding(.vertical, 12)
                        .padding(.horizontal, 20)
                        .background(
                            RoundedRectangle(cornerRadius: 16)
                                .fill(Color(red: 64/255, green: 121/255, blue: 57/255))
                        )
                        .padding()
                }

                
                //button to nav to start -- welcome view 1st page
                NavigationLink(destination: WelcomeView(countManager: countManager).navigationBarBackButtonHidden()) {
                    
                    VStack{
                        
                        Image("logo")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 50, height: 50)
//                            .padding(.bottom, 10)

                        
                        Text("reWIN")
                            .font(Font.custom("Inter", size: 30))
                            .foregroundColor(.black)
                            .padding(.bottom, 50)
    
                        
                    }
                }.simultaneousGesture(TapGesture().onEnded {
                    countManager.resetCount()
                })

            }
            .frame(maxWidth: .infinity, maxHeight: .infinity) // make VStack take up the entire screen so we can color whole screen
            .background(Color(red: 204/255, green: 224/255, blue: 194/255))
            .edgesIgnoringSafeArea(.all)
        }
        
    }
}



#Preview {
    WinView(countManager: CountManager())
}


