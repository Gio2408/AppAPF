//  ScoreManager.swift
//  AppAPF
//  Created by Michele Vassallo Todaro on 12/02/25.
// Manages quiz scores and tracks completed quizzes.

import Foundation
import SwiftUI

class ScoreManager: ObservableObject {
    @Published var score: QuizScore
    @Published var currentScore: Int = 0
    @Published var completedQuizzes: [QuizScore] = []
    
    private var quizManager: QuizManager
    
    // Initializes the ScoreManager with the given parameters.
    // Parameters:
    // score: The initial quiz score.
    // currentScore: The user's current score.
    // quizManager: The QuizManager instance for tracking quiz phases.
    init(score: QuizScore, currentScore: Int, quizManager: QuizManager) {
        self.score = score
        self.currentScore = currentScore
        self.quizManager = quizManager
    }
    
    // Retrieves the current phase index from the QuizManager.
    // Returns: The index of the current quiz phase.
    func getCurrentPhaseIndex() -> Int {
        return quizManager.currentPhaseIndex
    }
}

class QuizManager: ObservableObject {
    @Published var currentPhaseIndex: Int = 0  // Current quiz phase index.
}
