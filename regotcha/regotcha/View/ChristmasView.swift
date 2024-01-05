//
//  ChristmasView.swift
//  regotcha
//
//  Created by Chloe Nguyen on 12/1/23.
//

import SwiftUI

struct ChristmasView: View {
    @ObservedObject var countManager: CountManager
    @State private var userInput: String = ""
    @State var randomNumber: Int
    
    func answerMatch(randomNumber: Int) -> Bool {
        let gift = ChristmasModel.giftForDay(randomNumber)
        print("On the \(randomNumber) day of Christmas, my true love gave to me: \(String(describing: gift))")
        
        let giftWords = gift!.components(separatedBy: CharacterSet(charactersIn: " -"))
        
        let userInputWords = userInput.components(separatedBy: .whitespacesAndNewlines)
        
            
        for word in giftWords {
            if (2...6).contains(userInputWords.count) && userInput.lowercased().contains(word.lowercased()) {
                return true
            }
        }
        
        return false
    }
    
    var body: some View {
//        let randomNumber = Int.random(in: 1...12)
        
        VStack {
            Text("On the \(ordinalNumber(number: randomNumber)) day of Christmas, \n my true love gives to me:")
                .font(Font.custom("Inter", size: 15))
                .foregroundColor(.black)
                .multilineTextAlignment(.center)
                .padding(.top, 40)
            
            Spacer()
            
            Image("twelvedaysofchristmas")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(minWidth: 250, minHeight: 250)
                .padding()
            
            Spacer()
            
            TextInputView(userInput: $userInput)
                .padding(.bottom, 25)
                .onChange(of: userInput) {
                    countManager.answer = answerMatch(randomNumber: randomNumber)
                    countManager.loseMessage = "Well someone is not getting a present for Christmas."
                    print(countManager.answer)
            }
        }
    }
    
    private func ordinalNumber(number: Int) -> String {
        let suffix: String
        
        if number % 100 >= 11 && number % 100 <= 13 {
            suffix = "th"
        } else {
            switch number % 10 {
            case 1: suffix = "st"
            case 2: suffix = "nd"
            case 3: suffix = "rd"
            default: suffix = "th"
            }
        }
        
        return "\(number)\(suffix)"
    }
}

#Preview {
    ChristmasView(countManager: CountManager(), randomNumber: Int())
}
