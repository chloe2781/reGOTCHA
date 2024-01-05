//
//  FakeCaptcha.swift
//  regotcha
//
//  Created by Chloe Nguyen on 11/28/23.
//

import SwiftUI

struct FakeCaptcha: View {
    @ObservedObject var countManager: CountManager
    var body: some View {
        NavigationLink(destination: LoseView(countManager: countManager).navigationBarBackButtonHidden()) {
            Image("fakeCaptcha")
                .padding(40)
                .onAppear {
                    // Set the loseMessage when the view appears
                    countManager.loseMessage = "If you're a human you would obvious know it's a virus link."
                }

        }
    }
}

#Preview {
    FakeCaptcha(countManager: CountManager())
}
