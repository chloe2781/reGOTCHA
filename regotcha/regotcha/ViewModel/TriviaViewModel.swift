//
//  TriviaViewModel.swift
//  regotcha
//
//  Created by Carlos Raymundo on 11/30/23.
//

import Foundation

@MainActor
class TriviaViewModel: ObservableObject {
    @Published var triviaData: [TriviaData]?
    
    let loader = TriviaLoader()
    
    func fetchTriviaData() async {
//        if let result = try? await TriviaLoader().downloadTriviaDataAsync() {
//            self.triviaData = result
//        }
    }
}

