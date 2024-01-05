//
//  TextInputView.swift
//  regotcha
//
//  Created by Elizabeth Commisso on 11/9/23.
//

import SwiftUI

struct TextInputView: View {
    
    @Binding var userInput: String
    
    var body: some View {
        
        TextField("Enter some text", text: $userInput)
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
    TextInputView(userInput: .constant("Preview Text"))
}
