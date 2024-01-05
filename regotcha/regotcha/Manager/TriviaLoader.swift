//
//  TriviaLoader.swift
//  regotcha
//
//  Created by Carlos Raymundo on 11/22/23.
//

import Foundation

class TriviaLoader {
    var apiUrl = "https://the-trivia-api.com/v2/questions/"
    
//    func handleTriviaData(data: Foundation.Data?) -> [TriviaData]? {
//        guard
//            let data = data,
//            let triviaData = try? JSONDecoder().decode([TriviaData].self, from: data) else {
//            return nil
//        }
//        return triviaData
//    }
//    
//    func downloadTriviaDataAsync() async throws -> [TriviaData]? {
//        guard let url = URL(string: apiUrl) else {
//            throw URLError(.badURL)
//        }
//        
//        do {
//            let (data, _) = try await URLSession.shared.data(from: url, delegate: nil)
//            return handleTriviaData(data: data)
//        } catch {
//            throw error
//        }
//    }
}


