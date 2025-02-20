import Foundation
import SwiftUI

class ScoreManager: ObservableObject {
    
    @Published var currentQuestion: Int // This variable is used to define the current question, so it can be compared with the total number of questions
    @Published var mTotalScore: Int // Temporary variable for the player's score
    @Published var mWarningTotalScore: Int // Temporary variable for the player's score
    @Published var score : QuizScore // Variable-structure of type QuizScore used to get the scores to put in the score.
                                    // Variables in QuizScore:
                                    // - totalScore: number of correct answers
                                    // - totalAnswers: number of total answers
    
    @Published var WarningScore : QuizScore
    
    let scoreKey = "totalScore"
    let answersKey = "totalAnswers"
    
    let WarningScoreKey = "WarningScore"
    let WarningAnswersKey = "WarningAnswers"
    
    
    init(score: QuizScore = QuizScore(quiz: "", totalScore: 0, totalAnswers: 0),
         WarningScore: QuizScore = QuizScore(quiz: "", totalScore: 0, totalAnswers: 0),
         currentQuestion: Int = 0, mTotalScore: Int = 0, mWarningTotalScore: Int = 0){
        self.score = score
        self.WarningScore = WarningScore
        self.currentQuestion = currentQuestion
        self.mTotalScore = mTotalScore
        self.mWarningTotalScore = mWarningTotalScore
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
    
    func incrementWarningScore(){
        mWarningTotalScore += 1
    }
    
    
    // FUNCTIONS FOR SCORE
    func saveScore(){
        score.totalScore = mTotalScore
        UserDefaults.standard.set(score.totalScore, forKey: scoreKey)
        objectWillChange.send()

    }
    
    func loadScore(){
        let savedScore = UserDefaults.standard.integer(forKey: scoreKey)
        score.totalScore = savedScore
    }
    
    // FUNCTIONS FOR WARNING SCORE
    func saveWarningScore(){
        WarningScore.totalScore = mWarningTotalScore
        UserDefaults.standard.set(WarningScore.totalScore, forKey: WarningScoreKey)
        objectWillChange.send()

    }
    
    func loadWarningScore(){
        let savedWarningScore = UserDefaults.standard.integer(forKey: WarningScoreKey)
        WarningScore.totalScore = savedWarningScore
    }
    
    
    // RESET FUNCTIONS
    
    func resetQuestion(){
        self.currentQuestion = 0
    }
    
    func resetScore(){
        self.mTotalScore = 0
    }
    
    func resetWarningScore(){
        self.mWarningTotalScore = 0
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
    
    // FUNCTIONS FOR WARNING TOTAL ANSWERS
    func saveWarningAnswers(){
        UserDefaults.standard.set(WarningScore.totalAnswers, forKey: WarningAnswersKey)
        print("saveWarningAnswers: WTA = \(WarningScore.totalAnswers)")
    }
    
    func loadWarningAnswers(){
        let savedWarningAnswers = UserDefaults.standard.integer(forKey: WarningAnswersKey)
        WarningScore.totalAnswers = savedWarningAnswers
    }
}
