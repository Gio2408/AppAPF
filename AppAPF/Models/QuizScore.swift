// Represents the score of a quiz, including total points and the number of answers.
import Foundation

class QuizScore: Observable {
    var quiz: String        
    var totalScore: Int
    var totalAnswers: Int
    var levelC: Int
  
    init(quiz: String, totalScore: Int = 0, totalAnswers: Int, levelC: Int = 0) {
        self.quiz = quiz
        self.totalScore = totalScore
        self.totalAnswers = totalAnswers
        self.levelC = levelC
    }
}


