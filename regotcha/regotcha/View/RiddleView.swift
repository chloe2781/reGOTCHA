//
//  RiddleView.swift
//  regotcha
//
//  Created by Elizabeth Commisso on 11/30/23.
//

import SwiftUI

struct RiddleView: View {
    @ObservedObject var countManager: CountManager
    @StateObject private var riddleViewModel = RiddleViewModel()
    let questionText = "Solve the following riddle: "
    @State private var riddleQuestion = "N/A"
    @State private var riddleAnswer = "N/A"
    @State private var userInput: String = ""
    @State private var isFetchingRiddle = false
    @State private var rotationAngle: Double = 0.0
    
    
    var answerMatch: Bool {
        let punctuationCharacterSet = CharacterSet.punctuationCharacters

        let cleanedRiddleAnswer = riddleAnswer.components(separatedBy: punctuationCharacterSet).joined()

        let cleanedUserInput = userInput.components(separatedBy: punctuationCharacterSet).joined()

        let answerWords = cleanedRiddleAnswer.components(separatedBy: " ")

        for word in answerWords {
            if cleanedUserInput.lowercased().contains(word.lowercased()) {
                print("Riddle answer match \(word) and \(cleanedUserInput)")
                return true
            }
        }

        return false
    }

    
    
    var body: some View {
        VStack {
            // prompt
            VStack{
                Text(questionText)
                    .font(Font.custom("Inter", size: 15))
                    .foregroundColor(.black)
                    .multilineTextAlignment(.leading)
                    .padding(.top, 40)
                    .padding(.bottom, -70)
                
                Spacer()
                
                // Display riddle question
                if let question = riddleViewModel.riddle {
                    Text(question)
                        .font(Font.custom("Inter", size: 20))
                        .foregroundColor(.black)
                        .padding()
                        .background(Color.gray.opacity(0.3))
                        .cornerRadius(8)
                }
                
                Spacer()
                
                //                TextInputView(userInput: $userInput)
                //                    .padding(.bottom, 25)
//                Text("Riddle Answer: \(riddleAnswer)")
//                Spacer()
                
                
                HStack {
                    TextInputView(userInput: $userInput)
                        .padding(.bottom, 25)
                        .onAppear {
                            fetchNewRiddle()
                        }
                        .onReceive(riddleViewModel.$answer) { newAnswer in
                            riddleAnswer = newAnswer ?? "N/A"
                            print("Answer: \(riddleAnswer)")
                        }
                        .onChange(of: userInput) {
                            countManager.answer = answerMatch
                            countManager.loseMessage = "Tsk, you can't solve riddles. Only robots don't know word play."
                        }
                    
                    Button(action: {
                        fetchNewRiddle()
                        withAnimation(Animation.linear(duration: 0.5)) {
                                // Animate the rotation effect for 3 seconds\
                            rotationAngle += 360
                        }
//                        print("POST BUTTON")
                    }) {
                        Image(systemName: "arrow.counterclockwise.circle")
                            .font(.system(size: 30))
                            .fontWeight(.light)
                            .foregroundColor(.gray)
                            .rotationEffect(
                                .degrees(-rotationAngle)
                            )
                    }
                    .padding(.bottom, 40)
                }
                
            }
        }

    }
    
    private func fetchNewRiddle() {
        riddleViewModel.fetchRandomRiddle {
            if let question = riddleViewModel.riddle {
                if wordCount(question) >= 20{
                    print("FETCHING NEW RIDDLE")
                    fetchNewRiddle()
                }
                else{
                    riddleQuestion = question
                }
            } else {
                riddleQuestion = "N/A"
            }
            if let answer = riddleViewModel.answer{
                if wordCount(answer) >= 5 {
                    fetchNewRiddle()
                }
            }
        }
    }

    
    private func wordCount(_ text: String) -> Int {
        print("Input Text: \(text)")
        
        let words = text.components(separatedBy: " ")
        var counter = 0
        
        for _ in words {
            counter += 1
        }
        
        let validWords = words.filter { !$0.isEmpty }
        print("Word Count: \(counter)")
        
        return validWords.count
    }


}

struct RiddleView_Previews: PreviewProvider {
    static var previews: some View {
        RiddleView(countManager: CountManager())
    }
}
