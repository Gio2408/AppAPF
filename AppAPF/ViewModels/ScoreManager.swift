//
//  ScoreManager.swift
//  AppAPF
//
//  Created by Michele Vassallo Todaro on 12/02/25.
//

import Foundation

class ScoreManager: ObservableObject {
    @Published var score: QuizScore
    @Published var currentScore: Int = 0
    
    init(score: QuizScore, currentScore: Int) {
        self.score = score
        self.currentScore = currentScore
    }
    func addScore(_ newScore: QuizScore) {
        
        currentScore += newScore.record
        
    }
}
