//
//  ScoreManager.swift
//  AppAPF
//
//  Created by Michele Vassallo Todaro on 12/02/25.
//

import Foundation
import SwiftUI

class ScoreManager: ObservableObject {
    
    @Published var currentQuestion: Int // Questa variabile serve per andare a definire la domanda attuale, in modo da confrontarla con il numero delle domande totali
    @Published var score : QuizScore //variabile-struttura di tipo QuizScore che serve a prendere i punteggi da mettere nello score.                                                Variabili in QuizScore:                                                                                                                     - totalScore: numero di risposte corrette                                                                                                - totalAnswer: numero di risposte totali
    
    private let key = "totalScore"
    
    init(score: QuizScore = QuizScore(quiz: "", totalScore: 0, totalAnswers: 0), currentQuestion: Int = 0){
        self.score = score
        self.currentQuestion = currentQuestion
    }
    
    func addCurrentQuestion(){ // aggiorna il contatore della domanda corrente
        self.currentQuestion += 1
    }
    
    func addTotalScore(){ // contatore delle risposte corrette
        score.totalScore += 1
    }
    
    func saveScore(){ // ancora da definire bene
            
    }

}

