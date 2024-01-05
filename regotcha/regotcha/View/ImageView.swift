//
//  ImageView.swift
//  regotcha
//
//  Created by Elizabeth Commisso on 11/9/23.
//

import SwiftUI

struct ImageView: View {
    @State var userInput: String = ""
    var body: some View {
        VStack{
            Text("This is the description of the question")
                .font(Font.custom("Inter", size: 15))
                .foregroundColor(.black)
                .multilineTextAlignment(.leading)
                .padding(.top, 20)
            
            //default image
            Image("image")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding()
                .frame(minWidth: 150, minHeight: 150)
            
            TextInputView(userInput: $userInput)
        }
    }
}

#Preview {
    ImageView()
}
