//
//  CountManager.swift
//  regotcha
//
//  Created by Chloe Nguyen on 11/23/23.
//

import Combine

class CountManager: ObservableObject {
    @Published var count: Int = 0
    @Published var highScore: Int = 0
    @Published var username: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var answer: Bool = true
    @Published var win: Bool = false
    @Published var isLogin: Bool = false
    @Published var loseMessage: String = "You're a robot.\n Go away."
    
    
    func resetCount() {
        username = ""
        password = ""
        count = 0
        answer = true
        win = false
        isLogin = false
    }

}
