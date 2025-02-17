//  ScoreManager.swift
//  AppAPF
//  Created by Michele Vassallo Todaro on 12/02/25.
// Manages quiz scores and tracks completed quizzes.

import Foundation
import SwiftUI

class ScoreManager: ObservableObject {
    
    @Published var currentQuestion: Int // This variable is used to define the current question, so it can be compared with the total number of questions
    @Published var mTotalScore: Int // Temporary variable for the player's score
    @Published var score : QuizScore // Variable-structure of type QuizScore used to get the scores to put in the score.
                                    // Variables in QuizScore:
                                    // - totalScore: number of correct answers
                                    // - totalAnswers: number of total answers
    
    let scoreKey = "totalScore"
    let answersKey = "totalAnswers"
    
    init(score: QuizScore = QuizScore(quiz: "", totalScore: 0, totalAnswers: 0), currentQuestion: Int = 0, mTotalScore: Int = 0){
        self.score = score
        self.currentQuestion = currentQuestion
        self.mTotalScore = mTotalScore
        loadScore()
        loadAnswers()
    }
    
    // INCREMENT FUNCTIONS
    func incrementQuestion(){ // Updates the current question counter
        self.currentQuestion += 1
    }
    
    func incrementScore(){ // Counter for correct answers
        mTotalScore += 1
    }
    
    // FUNCTIONS FOR SCORE
    func saveScore(){
        score.totalScore = mTotalScore
        UserDefaults.standard.set(score.totalScore, forKey: scoreKey)
    }
    
    func loadScore(){
        let savedScore = UserDefaults.standard.integer(forKey: scoreKey)
        score.totalScore = savedScore
    }
    
    // RESET FUNCTIONS
    
    func resetQuestion(){
        self.currentQuestion = 0
    }
    
    func resetScore(){
        self.mTotalScore = 0
    }
    
    // FUNCTIONS FOR TOTAL ANSWERS
    func saveAnswers(){
        UserDefaults.standard.set(score.totalAnswers, forKey: answersKey)
        print("saveAnswers: TA = \(score.totalAnswers)")
    }
    
    func loadAnswers(){
        let savedAnswers = UserDefaults.standard.integer(forKey: answersKey)
        score.totalAnswers = savedAnswers
    }
}
