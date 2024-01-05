//
//  TriviaData.swift
//  regotcha
//
//  Created by Carlos Raymundo on 11/30/23.
//

struct TriviaData: Codable {
    let category, id, correctAnswer: String
    let incorrectAnswers: [String]
    let question: Question
    let tags: [String]
    let type: TypeEnum
    let difficulty: Difficulty
    let isNiche: Bool
}

enum Difficulty: String, Codable {
    case hard = "hard"
    case medium = "medium"
}

// MARK: - Question
struct Question: Codable {
    let text: String
}

enum TypeEnum: String, Codable {
    case textChoice = "text_choice"
}
