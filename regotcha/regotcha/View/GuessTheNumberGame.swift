//
//  GuessTheNumberGame.swift
//  regotcha
//
//  Created by Carlos Raymundo on 12/2/23.
//

import SwiftUI

struct GuessTheNumberGameView: View {
    @ObservedObject var countManager: CountManager
    @State private var targetNumber = Int.random(in: 1...10)
    @State private var enteredNumber = ""
    @State private var showingResult = false
    @State private var remainingTries = 3
    @State private var hint = ""

    var body: some View {
        VStack {
            Text("Guess the number: 1-10")
                .font(Font.custom("Inter", size: 20))
                .padding(.top, 40)
            
            TextField("Enter your guess", text: $enteredNumber)
                .keyboardType(.numberPad)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Button("Submit") {
                checkGuess()
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)

            Spacer()

            if showingResult {
                if remainingTries > 0 {
                    Text("Correct! The number was \(targetNumber).")
                        .foregroundColor(.green)
                        .padding()
                } else {
                    Text("Sorry! You've run out of tries. The correct number was \(targetNumber).")
                        .foregroundColor(.red)
                        .padding()
                    
                }
            } else {
                Text("Tries remaining: \(remainingTries)")
                    .foregroundColor(.blue)
                    .padding()

                Text(hint)
                    .foregroundColor(.blue)
                    .padding()
            }
        }
        .padding()
    }

    private func checkGuess() {
        guard let guessedNumber = Int(enteredNumber) else { return }

        if guessedNumber == targetNumber {
            showingResult = true
        } else {
            remainingTries -= 1

            if remainingTries > 0 {
                hint = guessedNumber < targetNumber ? "Try a higher number." : "Try a lower number."
            }

            if remainingTries == 0 {
                showingResult = true
                countManager.answer = false
                countManager.loseMessage = "Better luck next time, ROBOT!"
            }
        }
    }
}

struct GuessTheNumberGameView_Previews: PreviewProvider {
    static var previews: some View {
        GuessTheNumberGameView(countManager: CountManager())
    }
}

