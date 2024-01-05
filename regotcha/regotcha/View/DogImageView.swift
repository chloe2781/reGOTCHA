//
//  DogImageView.swift
//  regotcha
//
//  Created by Elizabeth Commisso on 11/16/23.
//

import SwiftUI

struct DogImageView: View {
    @ObservedObject var countManager: CountManager
    @StateObject private var dogImageViewModel = DogImageViewModel()
    let questionText = "What dog breed is this?"
    @State private var breedText = "N/A"
    @State private var userInput: String = ""
    @State private var isLoaded = false
    @State private var rotationAngle: Double = 0.0
    
    var breedMatch: Bool {
        let breedWords = breedText.components(separatedBy: " ")
        for word in breedWords {
            if userInput.contains(word) {
                return true
            }
        }
        return false
    }
    
    var body: some View {
        VStack{
            Text(questionText)
                .font(Font.custom("Inter", size: 15))
                .foregroundColor(.black)
                .multilineTextAlignment(.leading)
                .padding(.top, 40)
            
            Spacer()
            
            AsyncImage(url: dogImageViewModel.imageURL) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding()
                    .frame(minWidth: 150, minHeight: 300)
                    .onReceive(dogImageViewModel.$imageURL) {_ in
                        isLoaded = false
                    }
                    .onAppear {
                        isLoaded = true
                    }
                    .onChange(of: dogImageViewModel.imageURL) {
                        if dogImageViewModel.imageURL != nil {
                            isLoaded = true
                        }
                        else {
                            isLoaded = false
                            startTimer()
                        }
                    }
            } placeholder: {
                ProgressView()
                    .onAppear {
                        startTimer()
                    }
            }
            
            Spacer()

            HStack {
                TextInputView(userInput: $userInput)
                    .padding(.bottom, 25)
                
                Button(action: {
                    isLoaded = false
                    startTimer()
                    withAnimation(Animation.linear(duration: 3.0)) {
                            // Animate the rotation effect for 3 seconds\
                        rotationAngle += 3600
                    }

                }){
                    Image(systemName: "arrow.counterclockwise.circle")
                        .font(.system(size: 30))
                        .fontWeight(.light)
                        .foregroundColor(.gray)
                        .rotationEffect(
                            .degrees(isLoaded ? 0 : -rotationAngle)
                        )
                }
                .padding(.bottom, 40)
            }
            //            Text("LOADED?: \(isLoaded ? "true" : "false")")
//            Text("Breed: \(breedText)")
//            Text("Match: \(countManager.answer ? "True" : "False")")
        }
        .onAppear {
            dogImageViewModel.fetchRandomDogImage{}
        }
        .onReceive(dogImageViewModel.$breed) { newBreed in
            breedText = newBreed ?? "N/A"
            print(breedText)
        }
        .onChange(of: userInput) {
            countManager.answer = breedMatch
            countManager.loseMessage = "You're not a dog lover. Only robots don't have hearts."
        }
    }
    
    private func startTimer() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            if !isLoaded {
                isLoaded = false
                dogImageViewModel.fetchRandomDogImage {}
                startTimer() 
            }
        }
    }
}

#Preview {
    DogImageView(countManager: CountManager())
}
