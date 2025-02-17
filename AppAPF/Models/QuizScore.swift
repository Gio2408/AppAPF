//
//  RoadJunctionError.swift
//  AppAPF
//
//  Created by Michele Vassallo Todaro on 10/02/25.
//
// Represents the score of a quiz, including total points and the number of answers.

import Foundation

struct QuizScore: Observable {
    var quiz: String        
    var totalScore: Int
    var totalAnswers: Int
    
  
    init(quiz: String, totalScore: Int = 0, totalAnswers: Int) {
        self.quiz = quiz
        self.totalScore = totalScore
        self.totalAnswers = totalAnswers
    }
}


