//
//  FoodImageView.swift
//  regotcha
//
//  Created by Chloe Nguyen on 12/1/23.
//

import SwiftUI

struct FoodImageView: View {
    @ObservedObject var countManager: CountManager
    @StateObject private var foodImageViewModel = FoodImageViewModel()
    let questionText = "What food is this?"
    @State private var foodText = "N/A"
    @State private var foodurl :String = ""
    @State private var userInput: String = ""
    @State private var isLoaded = false
    @State private var rotationAngle: Double = 0.0
    
    var answerMatch: Bool {
        let answerWords = foodText.components(separatedBy: " ")
        for word in answerWords {
            if userInput.lowercased().contains(word.lowercased()) {
                return true
            }
        }
        return false
    }
    
    var body: some View {
        VStack {
            Text(questionText)
                .font(Font.custom("Inter", size: 15))
                .foregroundColor(.black)
                .multilineTextAlignment(.leading)
                .padding(.top, 40)

            Spacer()

            AsyncImage(url: foodImageViewModel.imageURL) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding()
                    .frame(minWidth: 150, minHeight: 300)
                    .onReceive(foodImageViewModel.$imageURL) { _ in
                        isLoaded = false
                    }
                    .onAppear {
                        isLoaded = true
                    }
                    .onChange(of: foodImageViewModel.imageURL) {
                        if foodImageViewModel.imageURL != nil {
                            isLoaded = true
                        } else {
                            isLoaded = false
                            startTimer()
                        }
                    }
            } placeholder: {
                if !isLoaded {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
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
                }) {
                    Image(systemName: "arrow.counterclockwise.circle")
                        .font(.system(size: 30))
                        .fontWeight(.light)
                        .foregroundColor(.gray)
                        .rotationEffect(.degrees(isLoaded ? 0 : -rotationAngle))
                }
                .padding(.bottom, 40)
            }

//            Text("LOADED?: \(isLoaded ? "true" : "false")")
//            Text("Food: \(foodText)")
//            Text("URL: \(foodurl)")
//            Text("Match: \(countManager.answer ? "True" : "False")")
        }
        .onAppear {
            foodImageViewModel.fetchRandomFoodImage{}
        }
        .onReceive(foodImageViewModel.$food) { newFood in
            foodText = newFood ?? "N/A"
            print(foodText)
        }
        .onReceive(foodImageViewModel.$image) { url in
            foodurl = url ?? "N/A"
        }
        .onChange(of: userInput) {
            countManager.answer = answerMatch
            countManager.loseMessage = "You're not a food lover, you're the worst kind of robot. GOTCHA!"
        }
    }

    private func startTimer() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            if !isLoaded {
                isLoaded = false
                foodImageViewModel.fetchRandomFoodImage {}
                startTimer()
            }
        }
    }
}

#Preview {
    FoodImageView(countManager: CountManager())
}
