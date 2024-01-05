//
//  MultipleChoiceView.swift
//  regotcha
//
//  Created by Elizabeth Commisso on 11/9/23.
//

import SwiftUI

struct MultipleChoiceView: View {
    @State private var selectedOption: Int?
    var question: String
    var correctAnswer: String
    var incorrectAnswers: [String]

    private var shuffledOptions: [Int] {
        var options = Array(0..<incorrectAnswers.count + 1)
        options.shuffle()
        return options
    }

    var body: some View {
        VStack {
            Text("Trivia Question:")
                .font(Font.custom("Inter", size: 30))
                .foregroundColor(.black)
                .padding()

            Text(question)
                .font(Font.custom("Inter", size: 20))
                .padding()

            VStack(alignment: .leading, spacing: 20) {
                ForEach(shuffledOptions, id: \.self) { index in
                    Button(action: {
                        self.selectedOption = index
                        checkAnswer()
                    }) {
                        HStack {
                            Text(index == 0 ? correctAnswer : incorrectAnswers[index - 1])
                                .foregroundColor(getOptionColor(index))
                                .padding(10)
                                .background(Color.gray.opacity(0.3))
                                .cornerRadius(10)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(getOptionBorderColor(index), lineWidth: 2)
                                )
                        }
                    }
                    .disabled(selectedOption != nil) // Disable buttons once an answer is selected
                }
            }
        }
        .padding()
    }

    private func checkAnswer() {
        if let selectedOption = selectedOption {
            let selectedAnswer = selectedOption == 0 ? correctAnswer : incorrectAnswers[selectedOption - 1]
            let isCorrect = selectedAnswer == correctAnswer
            print("Selected Answer: \(selectedAnswer), Correct: \(isCorrect)")
        }
    }

    private func getOptionColor(_ index: Int) -> Color {
        if let selectedOption = selectedOption {
            let selectedAnswer = index == 0 ? correctAnswer : incorrectAnswers[index - 1]
            return selectedOption == index ? (selectedAnswer == correctAnswer ? .green : .red) : .primary
        } else {
            return .primary
        }
    }

    private func getOptionBorderColor(_ index: Int) -> Color {
        if let selectedOption = selectedOption, selectedOption == index {
            return correctAnswer == (index == 0 ? correctAnswer : incorrectAnswers[index - 1]) ? .green : .red
        } else {
            return .clear
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MultipleChoiceView(question: "What is the capital of France?",
                           correctAnswer: "Paris",
                           incorrectAnswers: ["Berlin", "Madrid", "London"])
    }
}




#Preview {
    MultipleChoiceView(question: "What is the capital of France?",
                       correctAnswer: "Paris",
                       incorrectAnswers: ["Berlin", "Madrid", "London"])
}
