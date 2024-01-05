//
//  DiceRollGame.swift
//  regotcha
//
//  Created by Carlos Raymundo on 12/2/23.
//

import SwiftUI

struct DiceRollGameView: View {
    @ObservedObject var countManager: CountManager
    @State private var diceResult: Int?
    @State private var userGuess: Int?
    @State private var remainingTries = 3
    @State private var gameWon = false
    @State private var gameLost = false

    var body: some View {
        VStack {
            Text("Dice Roll Game")
                .font(.title)
                .padding()

            Image(systemName: diceResult != nil ? "die.face.\(diceResult!)" : "questionmark.square.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 100)
                .padding()

            Text("Remaining Tries: \(remainingTries)")
                .font(.headline)
                .padding()

            HStack {
                ForEach(1...6, id: \.self) { number in
                    Button("\(number)") {
                        makeGuess(number)
                    }
                    .padding()
                    .font(Font.custom("Inter", size: 20))
                    .background(Color.gray)
                    .foregroundColor(.white)
                    .cornerRadius(15)
                    .disabled(userGuess != nil)
                }
            }

            if let userGuess = userGuess {
                Text("Your guess: \(userGuess)")
                    .font(.headline)
                    .padding()
            }

            Button("Roll Dice") {
                rollDice()
            }
            .padding()
            .font(Font.custom("Inter", size: 20))
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(15)
            .disabled(userGuess == nil || remainingTries == 0 || gameWon || gameLost)

            if gameWon {
                Text("You won!")
                    .font(.headline)
                    .foregroundColor(.green)
                    .padding()
            } else if gameLost {
                Text("You lose!")
                    .font(.headline)
                    .foregroundColor(.red)
                    .padding()
            }
        }
        .padding()
    }

    private func makeGuess(_ guess: Int) {
        userGuess = guess
    }

    private func rollDice() {
        guard let userGuess = userGuess else { return }

        diceResult = Int.random(in: 1...6)
//        diceResult = 6
        print(diceResult ?? "NONE")

        if userGuess == diceResult {
            gameWon = true
        } else {
            remainingTries -= 1
            if remainingTries == 0 {
                gameLost = true
            }
        }
    }
}

struct DiceRollGameView_Previews: PreviewProvider {
    static var previews: some View {
        DiceRollGameView(countManager: CountManager())
    }
}
