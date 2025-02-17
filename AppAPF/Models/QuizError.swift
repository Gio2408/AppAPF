//
//  RoadJunctionError.swift
//  AppAPF
//
//  Created by Michele Vassallo Todaro on 10/02/25.
//
// Represents an error made during a quiz session.

import Foundation

struct QuizError: Codable, Identifiable {
    let id: UUID                // Unique identifier for the error
    let question: String        // The quiz question where the error occurred
    let correctAnswer: String   // The correct answer
    let userAnswer: String      // The user's incorrect answer
    
    //  Initializes a new QuizError instance.
    //  - Parameters:
    //  - question: The question where the user made a mistake.
    //  - correctAnswer: The correct answer to the question.
    //  - userAnswer: The incorrect answer provided by the user.
    init(question: String, correctAnswer: String, userAnswer: String) {
        self.id = UUID()
        self.question = question
        self.correctAnswer = correctAnswer
        self.userAnswer = userAnswer
    }
}
