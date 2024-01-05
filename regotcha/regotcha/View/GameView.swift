//
//  GameView.swift
//  regotcha
//
//  Created by Elizabeth Commisso on 11/8/23.
//

import SwiftUI

struct GameView: View {
    @ObservedObject var countManager: CountManager
    @State private var countToPass = 0
    
    var body: some View {
        VStack {
            // the game will appear in the window below
            Rectangle()
            .foregroundColor(.clear)
            .frame(minWidth: 350, minHeight: 400)
            .background(.white)
            .overlay(
            Rectangle()
            .inset(by: 0.5)
            .stroke(Color(red: 0.62, green: 0.62, blue: 0.62), lineWidth: 1)
            )
//            .padding(20)
            
            // use conditionals here to determine which view we will be using!
            .overlay(
//                ImageView()
//                GameViewMap()
//                MultipleChoiceView()
//                Group {
//                    if countManager.isLogin{
//                        getViewForCount(Int.random(in: 3...10))
//                    }
//                    else{
                getViewForCount(countManager.count)
//                    }
//                }
            )
            .padding()
//            .onChange(of: countManager.count) {
//                countToPass = countManager.count
                
//                if countManager.isLogin{
////                    countToPass = Int.random(in: 3...10)
////                    print(countToPass)
//                    getViewForCount(Int.random(in: 3...10))
//                }
//                else{
////                    countToPass = countManager.count
//                    getViewForCount(countManager.count)
//                }
//            }
            
            Spacer()
//            GameViewObject()
               
        }
    }
    
//    private
    
    
    private func getViewForCount(_ count: Int) -> some View {
        switch count % 14 {
        // case 1 = reenter password in content view
            
        // case 2 = REAL captcha in content view -- there so it will not be in the box format like the other views
        
        case 3:
            return AnyView(GameViewMap(countManager: countManager))
        case 4:
            return AnyView(DogImageView(countManager: countManager))

        // case 5 = fake captcha in content view -- there so it will not be in the box format like the other views
            
        case 6:
            return AnyView(FoodImageView(countManager: countManager))

        case 7:
            return AnyView(RotationGameView(countManager: countManager))

        case 8:
            let randomNumber = Int.random(in: 1...12)
            return AnyView(ChristmasView(countManager: countManager, randomNumber: randomNumber))
            
        case 9:
            return AnyView(RiddleView(countManager: countManager))
            
        case 10:
            return AnyView(MusicView(countManager: countManager))
            
        case 11:
            return AnyView(JokeView(countManager: countManager))
            
//        case 12:
//            return AnyView(TriviaGame(countManager: countManager))
            
        case 12:
            return AnyView(GuessTheNumberGameView(countManager: countManager))
            
//        case 14:
//            return AnyView(RockPaperScissorsGameView(countManager: countManager))
            
        case 13:
            return AnyView(CoinTossGameView(countManager: countManager))
            
        case 14:
            return AnyView(DiceRollGameView(countManager: countManager))

        case 0:
            return AnyView(RotationGameView(countManager: countManager))

        default:
//            print("IM BEING CALLED NOOOOO")
//            let gameViews: [AnyView] = [
//                AnyView(GameViewMap(countManager: countManager)),
//                AnyView(DogImageView(countManager: countManager)),
//                AnyView(FoodImageView(countManager: countManager)),
//                AnyView(RotationGameView(countManager: countManager)),
//                AnyView(ChristmasView(countManager: countManager, randomNumber: Int.random(in: 1...12))),
//                AnyView(RiddleView(countManager: countManager)),
//                AnyView(MusicView(countManager: countManager)),
//                AnyView(JokeView(countManager: countManager))
//            ]
//
//            // Randomly select a game view
//            let randomIndex = Int.random(in: 0..<gameViews.count)
//            return gameViews[randomIndex]

            return AnyView(DogImageView(countManager: countManager))

        }
    }

}

#Preview {
    GameView(countManager: CountManager())
//        .background(Color(red: 1, green: 0.99, blue: 0.96))

}
