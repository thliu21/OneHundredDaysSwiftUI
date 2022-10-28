//
//  GameViewModel.swift
//  GuessTheFlag
//
//  Created by Tianhao Liu on 10/28/22.
//

import Foundation
import SwiftUI

class GameViewModel: ObservableObject {
    @Published var model: GameModel
    
    var flags: ArraySlice<String> {
        model.flags
    }
    
    var question: String {
        model.question
    }
    
    var score: Int {
        model.score
    }
    
    var isLastAnswerCorrect: Bool {
        model.isLastAnswerCorrect ?? false
    }
    
    init() {
        model = GameModel()
    }
    
    func choose(_ index: Int) {
        model.choose(index)
    }
    
    func nextQuestion() {
        model.resetGame()
    }
}
