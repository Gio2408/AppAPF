//
//  RoadJunctionError.swift
//  AppAPF
//
//  Created by Michele Vassallo Todaro on 10/02/25.
//
// Represents the score of a quiz, including total points and the number of answers.

import Foundation

struct QuizScore: Observable {
    var quiz: String        // Tipo del quiz (es. "Quiz Incroci")
    var totalScore: Int     // Risposte giuste (es. 2)
    var totalAnswers: Int   // Risposte totali (es. 10)
    
    // Inizializzazione con il tipo di quiz e il punteggio
    init(quiz: String, totalScore: Int, totalAnswers: Int) {
        self.quiz = quiz
        self.totalScore = totalScore
        self.totalAnswers = totalAnswers
    }
}


