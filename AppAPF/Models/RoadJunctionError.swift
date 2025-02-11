//
//  RoadJunctionError.swift
//  AppAPF
//
//  Created by Michele Vassallo Todaro on 10/02/25.
//
//Errore nei minigiochi ad incriocioid

import Foundation

struct QuizError: Codable, Identifiable {
    let id: UUID //codice univoco di ogni incrocio, Se sbagli due volte la stessa domanda gli errori avranno ID diversi anche se la question è uguale (da definire se va bene uesta modalità) uuid crea un codice in automatico
    let question: String
    let correctAnswer: String
    let userAnswer: String
    
    init(question: String, correctAnswer: String, userAnswer: String) {
        self.id = UUID()
        self.question = question
        self.correctAnswer = correctAnswer
        self.userAnswer = userAnswer
    }
}
