//
//  RealCaptcha.swift
//  regotcha
//
//  Created by Elizabeth Commisso on 12/3/23.
//

import SwiftUI

struct RealCaptcha: View {
    @ObservedObject var countManager: CountManager
    @State private var showCheckMark = false

    var body: some View {
        Button(action: {
            withAnimation {
                showCheckMark = true
            }
//            .offset(x: -100)
            
            // delay increment of count until affter we animate
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                // Increment the count when the button is clicked
                countManager.count += 1
                
                // Reset the animation
                withAnimation {
                    showCheckMark = false
                }
            }
        }) {
            ZStack {
                Image("realCaptcha")
                    .padding(40)
                
                if showCheckMark {
                    Image(systemName: "checkmark.circle")
                        .font(.system(size: 40))
                        .foregroundColor(.green)
                        .transition(.scale)
                        .offset(x: -100)
                }
            }
        }
    }
}

#Preview {
    RealCaptcha(countManager: CountManager())
}
