//
//  RPSGame.swift
//  regotcha
//
//  Created by Carlos Raymundo on 12/2/23.
//

import SwiftUI

enum Move: String, CaseIterable {
    case rock = "Rock"
    case paper = "Paper"
    case scissors = "Scissors"
}

struct RockPaperScissorsGameView: View {
    @ObservedObject var countManager: CountManager
    @State private var appMove = Move.allCases.randomElement()!
    @State private var userMove: Move?
    @State private var showingResult = false

    var body: some View {
        VStack {
            Text("Rock Paper Scissors")
                .font(Font.custom("Inter", size: 20))
                .padding()

            HStack(spacing: 20) {
                ForEach(Move.allCases, id: \.self) { move in
                    Button(action: {
                        if !showingResult {
                            self.makeMove(move)
                        }
                    }) {
                        Image(move.rawValue.lowercased())
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 100, height: 100)
                    }
                }
            }

            Spacer()

            if showingResult {
                Text("You chose \(userMove!.rawValue). \(resultText())")
                    .foregroundColor(resultColor())
                    .padding()
            }
        }
        .padding()
    }

    private func makeMove(_ move: Move) {
        userMove = move
        appMove = Move.allCases.randomElement()!
        
//        appMove = Move.rock

        if userMove == appMove {
            // If it's a draw, recursively call makeMove until it's not a draw
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.makeMove(Move.allCases.randomElement()!)
            }
        } else {
            showingResult = true
        }
    }

    private func resultText() -> String {
        guard let userMove = userMove else { return "" }

        if userMove == appMove {
            return "It's a draw! Go again."
        } else if (userMove == .rock && appMove == .scissors) ||
                  (userMove == .paper && appMove == .rock) ||
                  (userMove == .scissors && appMove == .paper) {
            countManager.answer = true
            return "You win!"
        } else {
            countManager.answer = false
            countManager.loseMessage = "Better luck next time, ROBOT!"
            return "You lose!"
        }
    }

    private func resultColor() -> Color {
        guard let userMove = userMove else { return .black }

        if userMove == appMove {
            return .gray
        } else if (userMove == .rock && appMove == .scissors) ||
                  (userMove == .paper && appMove == .rock) ||
                  (userMove == .scissors && appMove == .paper) {
            return .green
        } else {
            return .red
        }
    }
}

struct RockPaperScissorsGameView_Previews: PreviewProvider {
    static var previews: some View {
        RockPaperScissorsGameView(countManager: CountManager())
    }
}
