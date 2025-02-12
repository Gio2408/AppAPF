//
//  ScoreManager.swift
//  AppAPF
//
//  Created by Michele Vassallo Todaro on 12/02/25.
//

import Foundation
import SwiftUI

class ScoreManager: ObservableObject {
    @Published var score: QuizScore
    @Published var currentScore: Int = 0
    @Published var completedQuizzes: [QuizScore] = []
    
    private var quizManager: QuizManager
    
    init(score: QuizScore, currentScore: Int, quizManager: QuizManager) {
        self.score = score
        self.currentScore = currentScore
        self.quizManager = quizManager
    }
    
    func getCurrentPhaseIndex() -> Int {
            return quizManager.currentPhaseIndex
        }

}

class QuizManager: ObservableObject {
    @Published var currentPhaseIndex: Int = 0  // Variabile osservabile
}

