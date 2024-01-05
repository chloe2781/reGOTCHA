//
//  SecureTextInputView.swift
//  regotcha
//
//  Created by Gulshan Meem on 12/2/23.
//

import Foundation
import SwiftUI

struct SecureTextInputView: View {
    
    @Binding var userInput: String
    
    var body: some View {
        
        SecureField("Enter some text", text: $userInput)
            .padding()
            .frame(width: 281, height: 41)
            .background(Color.white)
            .cornerRadius(8)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .inset(by: 0.5)
                    .stroke(Color(red: 0.62, green: 0.62, blue: 0.62), lineWidth: 1)
            )
            .textFieldStyle(PlainTextFieldStyle())
            .padding(.bottom, 15)
            .autocorrectionDisabled()
            .autocapitalization(.none)
    }
}

#Preview {
    SecureTextInputView(userInput: .constant("Preview Text"))
}
