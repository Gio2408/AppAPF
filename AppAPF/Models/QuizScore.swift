//
//  RoadJunctionError.swift
//  AppAPF
//
//  Created by Michele Vassallo Todaro on 10/02/25.
//
// Represents the score of a quiz, including total points and the number of answers.

import Foundation

struct QuizScore: Codable {
    var quiz: String            // Quiz identifier or name
    var totalScore: Int         // Total score achieved
    var totalAnswers: Int       // Total number of answers in the quiz
    
    /// Initializes a new QuizScore instance.
    /// - Parameters:
    ///   - quiz: The name or identifier of the quiz.
    ///   - totalScore: The total score achieved.
    ///   - totalAnswers: The total number of answers, default is 10.
    init(quiz: String, totalScore: Int, totalAnswers: Int = 10) {
        self.quiz = quiz
        self.totalScore = totalScore
        self.totalAnswers = totalAnswers
    }
}


