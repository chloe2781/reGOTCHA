//
//  TriviaGame.swift
//  regotcha
//
//  Created by Carlos Raymundo on 11/30/23.
//

import SwiftUI

struct TriviaGame: View {
    @ObservedObject var countManager: CountManager
    @StateObject private var viewModel = TriviaViewModel()
    
    var body: some View {
        VStack {
            
            MultipleChoiceView(question: viewModel.triviaData?[0].question.text ?? "",
                                           correctAnswer: viewModel.triviaData?[0].correctAnswer ?? "",
                                           incorrectAnswers: viewModel.triviaData?[0].incorrectAnswers ?? [])
                            .padding()
            
           /* if let triviaData = viewModel.triviaData {
                Text(triviaData[0].question.text)
                    .padding()
                               
                VStack (alignment: .leading, spacing: 10) {
                        Text(triviaData[0].correctAnswer)
                        Text(triviaData[0].incorrectAnswers[0])
                        Text(triviaData[0].incorrectAnswers[1])
                        Text(triviaData[0].incorrectAnswers[2])
            
                }
            } */
        }
        .onAppear {
            Task {
                await viewModel.fetchTriviaData()
            }
        }
    }
}

struct TriviaGame_Previews: PreviewProvider {
    static var previews: some View {
        TriviaGame(countManager: CountManager())
    }
}

