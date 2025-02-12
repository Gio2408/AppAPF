//
//  RoadJunctionError.swift
//  AppAPF
//
//  Created by Michele Vassallo Todaro on 10/02/25.
//
//Errore nei minigiochi ad incriocioid

import Foundation

struct QuizScore: Codable {
     var quiz: String //Tipo del quiz che si aggiorna con una variabile per il tipo di quiz. ad esempiuo Quiz incroci, quiz vero falso ecc.
     var record: Int   //Punteggio per il singolo quiz. es: Quiz 1: 6/10
     let totalAnswers: Int // Risposte totali del quiz
    
     
    //builder delle costanti di sopra
     init(quiz: String, record: Int) {
     self.quiz = quiz
     self.record = record
     self.totalAnswers = 10
     }
}


