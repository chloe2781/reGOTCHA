//
//  CoinTossGame.swift
//  regotcha
//
//  Created by Carlos Raymundo on 12/2/23.
//

import SwiftUI

struct CoinTossGameView: View {
    @ObservedObject var countManager: CountManager
    @State private var userGuess: String?
    @State private var resultMessage: String?
    @State private var isCoinTossed = false
    @State private var isGameOver = false

    var body: some View {
        VStack {
            Text("Heads or Tails")
                .font(Font.custom("Inter", size: 15))
                .foregroundColor(.black)
                .multilineTextAlignment(.leading)
                .padding(.top, 80)

            
            Spacer()

            HStack {
                Button(action: { selectSide(side: "Heads") }) {
                    Image("heads")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100, height: 90)
                }

                Button(action: { selectSide(side: "Tails") }) {
                    Image("tails")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100, height: 100)
                }
            }
//            .padding(50)
            
            Spacer()

            Button("Toss Coin") {
                if !isGameOver {
                    tossCoin()
                    
                }
            }
//            .padding()
            .font(.headline)
            .background(Color.gray)
            .foregroundColor(.white)
            .cornerRadius(15)

            Spacer()
            
            if let userGuess = userGuess {
                Text("Your guess: \(userGuess)")
                    .font(.headline)
//                    .padding()
            }

//            Image(isCoinTossed ? (userGuess == resultMessage ? "win" : "lose") : "")
//                .resizable()
//                .aspectRatio(contentMode: .fit)
//                .frame(width: 100, height: 100)

            Text(resultMessage ?? "")
                .foregroundColor(isCoinTossed ? (userGuess == resultMessage ? .green : .red) : .blue)
                .padding()
        }
//        .padding()
    }

    func selectSide(side: String) {
        userGuess = side
    }

    func tossCoin() {
        guard let userGuess = userGuess else {
            resultMessage = "Please select Heads or Tails before tossing the coin."
            return
        }

        let coinSide = Bool.random() ? "Heads" : "Tails"
//        let coinSide = "Heads"
        isCoinTossed = true
        isGameOver = true
        print(coinSide)

        if userGuess == coinSide {
            resultMessage = "Congratulations! You win!"
            countManager.answer = true
        } else {
            resultMessage = "Sorry! You lose. The coin landed on \(coinSide)."
            countManager.answer = false
            countManager.loseMessage = "Better luck next time, ROBOT!"
        }
    }
}

struct CoinTossGameView_Previews: PreviewProvider {
    static var previews: some View {
        CoinTossGameView(countManager: CountManager())
    }
}
