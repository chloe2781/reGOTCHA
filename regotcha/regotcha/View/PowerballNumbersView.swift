//
//  PowerballNumbersView.swift
//  regotcha
//
//  Created by Elizabeth Commisso on 11/30/23.
//

import SwiftUI

struct PowerballNumbersView: View {
    @ObservedObject var countManager: CountManager
    @State private var userInput: String = ""
    
    var passwordsMatch: Bool {
        return userInput == countManager.password
    }
    
    var body: some View {
        VStack{
            Text("What were the winning powerball numbers on XXX?")
                .font(Font.custom("Inter", size: 15))
                .foregroundColor(.black)
                .padding(.leading, -120)
            TextInputView(userInput: $userInput)

        }
        .onChange(of: userInput) {
            countManager.answer = passwordsMatch
            countManager.loseMessage = "What kind of human doesn't make mistakes, you're definitely a robot."
        }
    }
}

#Preview {
    PowerballNumbersView(countManager: CountManager())
}
