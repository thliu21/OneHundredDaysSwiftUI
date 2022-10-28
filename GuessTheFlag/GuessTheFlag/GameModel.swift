//
//  GameModel.swift
//  GuessTheFlag
//
//  Created by Tianhao Liu on 10/28/22.
//

import Foundation

struct GameModel {
    private static let choiceCount = 3
    private static let countries = ["china", "france", "germany", "italy", "japan", "korea", "russia", "spain", "uk", "us"]
    
    private var correctAnswer: Int
    private(set) var flags: ArraySlice<String>
    var question: String {
        flags[correctAnswer]
    }
    
    private(set) var score = 0
    private(set) var isLastAnswerCorrect: Bool? = nil
    
    init() {
        self.correctAnswer = Int.random(in: 0..<Self.choiceCount)
        self.flags = Self.countries.shuffled().prefix(3)
    }
    
    mutating func resetGame() {
        correctAnswer = Int.random(in: 0..<Self.choiceCount)
        flags = Self.countries.shuffled().prefix(3)
        isLastAnswerCorrect = nil
    }
    
    mutating func choose(_ index: Int) {
        isLastAnswerCorrect = index == correctAnswer
        score += index == correctAnswer ? 1 : 0
    }
}
