import Foundation
import SwiftUI

class ScoreManager: ObservableObject {
    
    @Published var currentQuestion1: Int // This variable is used to define the current question, so it can be compared with the total number of questions
    @Published var mTotalScore1: Int // Temporary variable for the player's score
    @Published var score1 : QuizScore // Variable-structure of type QuizScore used to get the scores to put in the score.
                                    // Variables in QuizScore:
                                    // - totalScore: number of correct answers
                                    // - totalAnswers: number of total answers
    @Published var currentQuestion2: Int
    @Published var mTotalScore2: Int
    @Published var score2 : QuizScore
    
    let scoreKey = "totalScore"
    let answersKey = "totalAnswers"
    
    init(score: QuizScore = QuizScore(quiz: "", totalScore: 0, totalAnswers: 0, levelC: 0), currentQuestion: Int = 0, mTotalScore: Int = 0, currentQuestion2: Int = 0, mTotalScore2: Int = 0, score2: QuizScore = QuizScore(quiz: "", totalScore: 0, totalAnswers: 0, levelC: 1)){
        self.score1 = score
        self.currentQuestion1 = currentQuestion
        self.mTotalScore1 = mTotalScore
        self.score2 = score2
        self.currentQuestion2 = currentQuestion2
        self.mTotalScore2 = mTotalScore2
        loadScore()
        loadAnswers()
    }
    
    // INCREMENT FUNCTIONS
    func incrementQuestion(){ // Updates the current question counter
            self.currentQuestion1 += 1
            self.currentQuestion2 += 1
    }
    
    func incrementScore(){ // Counter for correct answers
        self.mTotalScore1 += 1
        self.mTotalScore2 += 1
    }
    
    // FUNCTIONS FOR SCORE
    func saveScore(){
        self.score1.totalScore = mTotalScore1
        UserDefaults.standard.set(score1.totalScore, forKey: scoreKey)
        self.score2.totalScore = mTotalScore2
        UserDefaults.standard.set(score2.totalScore, forKey: scoreKey)
    }
    
    func loadScore(){
        let savedScore = UserDefaults.standard.integer(forKey: scoreKey)
        score1.totalScore = savedScore
        let savedScore2 = UserDefaults.standard.integer(forKey: scoreKey)
        score2.totalScore = savedScore
    }
    
    // RESET FUNCTIONS
    
    func resetQuestion(){
        self.currentQuestion1 = 0
        self.currentQuestion2 = 0
    }
    
    func resetScore(){
        self.mTotalScore1 = 0
        self.mTotalScore2 = 0
    }
    
    // FUNCTIONS FOR TOTAL ANSWERS
    func saveAnswers(){
        UserDefaults.standard.set(score1.totalAnswers, forKey: answersKey)
        UserDefaults.standard.set(score2.totalAnswers, forKey: answersKey)
        print("saveAnswers: TA = \(score1.totalAnswers)")
    }
    
    func loadAnswers(){
        let savedAnswers = UserDefaults.standard.integer(forKey: answersKey)
        score1.totalAnswers = savedAnswers
    }
}
