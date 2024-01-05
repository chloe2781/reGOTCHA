//
//  JokeView.swift
//  regotcha
//
//  Created by Elizabeth Commisso on 12/2/23.
//

import SwiftUI

struct JokeView: View {
    @ObservedObject var countManager: CountManager
    @StateObject private var jokeViewModel = JokeViewModel()
    let questionText = "Complete the punchline: "
    @State private var jokeType = "N/A"
    @State private var jokeSetup = "N/A"
    @State private var jokeDelivery = "N/A"
    @State private var userInput: String = ""
    @State private var isFetchingJoke = false
    @State private var rotationAngle: Double = 0.0
    
    
    var answerMatch: Bool {
        let punctuationCharacterSet = CharacterSet.punctuationCharacters

            let cleanedJokeDelivery = jokeDelivery.components(separatedBy: punctuationCharacterSet).joined()

            let cleanedUserInput = userInput.components(separatedBy: punctuationCharacterSet).joined()

            let answerWords = cleanedJokeDelivery.components(separatedBy: " ")
            
            for word in answerWords {
                if cleanedUserInput.lowercased().contains(word.lowercased()) {
                    print("Joke answer match \(word) and \(cleanedUserInput)")
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
                
                // Display setup
                if let question = jokeViewModel.setup {
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
//                Text("Riddle Answer: \(jokeDelivery)")
//                Spacer()
                
                
                HStack {
                    TextInputView(userInput: $userInput)
                        .padding(.bottom, 25)
                        .onAppear {
                            fetchNewJoke()
                        }
                        .onReceive(jokeViewModel.$delivery) { newAnswer in
                            jokeDelivery = newAnswer ?? "N/A"
                            print("Answer: \(jokeDelivery)")
                        }
                        .onChange(of: userInput) {
                            countManager.answer = answerMatch
                            countManager.loseMessage = "Try again, machine! Humans know comedy!"
                        }
                    
                    Button(action: {
                        fetchNewJoke()
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
                    }.padding(.bottom, 40)
                }
                
            }
        }

    }
    
    private func fetchNewJoke() {
        jokeViewModel.fetchRandomJoke {
            if let type = jokeViewModel.type{
                if type != "Pun"{
                    print("fetching again")
                    fetchNewJoke()
                    return
                }
            }
            
            if let setup = jokeViewModel.setup {
                if wordCount(setup) >= 20{
                    print("FETCHING NEW JOKE")
                    fetchNewJoke()
                    return
                }
                else{
                    jokeSetup = setup
                }
            } else {
                jokeSetup = "N/A"
            }
            if let answer = jokeViewModel.delivery{
                if wordCount(answer) >= 5 {
                    fetchNewJoke()
                    return
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

#Preview {
    JokeView(countManager: CountManager())
}
