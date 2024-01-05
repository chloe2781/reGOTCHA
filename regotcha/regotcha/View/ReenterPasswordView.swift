//
//  ReenterPasswordView.swift
//  regotcha
//
//  Created by Chloe Nguyen on 11/23/23.
//

import SwiftUI

struct ReenterPasswordView: View {
    @ObservedObject var countManager: CountManager
    @State private var userInput: String = ""
    
    var passwordsMatch: Bool {
        return userInput == countManager.password
    }
    
    var body: some View {
        VStack{
            Text("Re-enter your password")
                .font(Font.custom("Inter", size: 15))
                .foregroundColor(.black)
                .padding(.leading, -120)
            SecureTextInputView(userInput: $userInput)

        }
        .onChange(of: userInput) {
            countManager.answer = passwordsMatch
            countManager.loseMessage = "How did you get that wrong, it's right there."
        }
    }
}

#Preview {
    ReenterPasswordView(countManager: CountManager())
}
