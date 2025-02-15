//  ScoreManager.swift
//  AppAPF
//  Created by Michele Vassallo Todaro on 12/02/25.
// Manages quiz scores and tracks completed quizzes.

import Foundation
import SwiftUI

class ScoreManager: ObservableObject {
    
    @Published var currentQuestion: Int // Questa variabile serve per andare a definire la domanda attuale, in modo da confrontarla con il numero delle domande totali
    @Published var score : QuizScore //variabile-struttura di tipo QuizScore che serve a prendere i punteggi da mettere nello score.                                                Variabili in QuizScore:                                                                                                                     - totalScore: numero di risposte corrette                                                                                                - totalAnswer: numero di risposte totali
    
    let scoreKey = "totalScore"
    
    init(score: QuizScore = QuizScore(quiz: "", totalScore: 0, totalAnswers: 0), currentQuestion: Int = 0){
        self.score = score
        self.currentQuestion = currentQuestion
        loadScore()
    }
    
    func incrementQuestion(){ // aggiorna il contatore della domanda corrente
        self.currentQuestion += 1
    }
    
    func incrementScore(){ // contatore delle risposte corrette
        score.totalScore += 1
    }
    
    func saveScore(){
        UserDefaults.standard.set(score.totalScore, forKey: scoreKey)
        print("Punteggio salvato \(score.totalScore)")
    }
    
    func loadScore(){
        let savedScore = UserDefaults.standard.integer(forKey: scoreKey)
        score.totalScore = savedScore
        print("Punteggio caricato: \(score.totalScore)")
    }
    
    func resetQuestion(){
        self.currentQuestion = 0
    }
}
