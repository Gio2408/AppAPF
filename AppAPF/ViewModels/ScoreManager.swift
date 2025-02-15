//  ScoreManager.swift
//  AppAPF
//  Created by Michele Vassallo Todaro on 12/02/25.
// Manages quiz scores and tracks completed quizzes.

import Foundation
import SwiftUI

class ScoreManager: ObservableObject {
    
    @Published var currentQuestion: Int // Questa variabile serve per andare a definire la domanda attuale, in modo da confrontarla con il numero delle domande totali
    @Published var mTotalScore: Int // variabile momentanea dello score del giocatore
    @Published var score : QuizScore //variabile-struttura di tipo QuizScore che serve a prendere i punteggi da mettere nello score.                                                Variabili in QuizScore:                                                                                                                     - totalScore: numero di risposte corrette                                                                                                - totalAnswer: numero di risposte totali
    
    let scoreKey = "totalScore"
    let answersKey = "totalAnswers"
    
    init(score: QuizScore = QuizScore(quiz: "", totalScore: 0, totalAnswers: 0), currentQuestion: Int = 0, mTotalScore: Int = 0){
        self.score = score
        self.currentQuestion = currentQuestion
        self.mTotalScore = mTotalScore
        loadScore()
        loadAnswers()
    }
    
    // FUNZIONI INCREMENT
    func incrementQuestion(){ // aggiorna il contatore della domanda corrente
        self.currentQuestion += 1
    }
    
    func incrementScore(){ // contatore delle risposte corrette
        mTotalScore += 1
    }
    
    //FUNZIONI PER SCORE
    func saveScore(){
        score.totalScore = mTotalScore
        UserDefaults.standard.set(score.totalScore, forKey: scoreKey)
    }
    
    func loadScore(){
        let savedScore = UserDefaults.standard.integer(forKey: scoreKey)
        score.totalScore = savedScore
    }
    
    // FUNZIONI RESET
    
    func resetQuestion(){
        self.currentQuestion = 0
    }
    
    func resetScore(){
        self.mTotalScore = 0
    }
    
    // FUNZIONI PER IL TOTALE
    func saveAnswers(){
        UserDefaults.standard.set(score.totalAnswers, forKey: answersKey)
        print("saveAnswers: TA = \(score.totalAnswers)")
    }
    
    func loadAnswers(){
        let savedAnswers = UserDefaults.standard.integer(forKey: answersKey)
        score.totalAnswers = savedAnswers
    }
}
