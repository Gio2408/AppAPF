//
//  ScoreView.swift
//  AppAPF
//
//  Created by Michele Vassallo Todaro on 12/02/25.
//

import Foundation
import SwiftUI

struct ScoreView: View {
    @EnvironmentObject var scoreManager: ScoreManager
    @Binding var isInScoreView: Bool // Binding per tornare alla schermata precedente

    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    withAnimation {
                        isInScoreView = false // Torna alla schermata precedente
                    }
                }) {
                    Image(systemName: "arrow.backward")
                        .font(.title)
                        .foregroundColor(.blue)
                }
                Spacer()
            }
            .padding()

            Text("Punteggi dei Quiz")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()

            // Mostra il punteggio attuale
            VStack(alignment: .leading, spacing: 10) {
                Text("Quiz attuale: \(scoreManager.score.quiz)")
                    .font(.title2)
                    .fontWeight(.semibold)
                
                Text("Punteggio: \(scoreManager.score.totalScore)/\(scoreManager.score.totalAnswers)")
                    .font(.headline)
                    .foregroundColor(.green)
                    .padding(.bottom, 20)
                
                // Barra di progresso
                ProgressView(value: Double(scoreManager.score.totalScore), total: Double(scoreManager.score.totalAnswers))
                    .progressViewStyle(LinearProgressViewStyle())
                    .padding(.bottom, 20)
            }
            .padding(.horizontal)
            
            // Lista dei punteggi passati
            VStack {
                Text("Punteggi precedenti")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .padding(.top)

                // Visualizza la lista dei quiz completati
                List(scoreManager.completedQuizzes, id: \.quiz) { completedQuiz in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(String(completedQuiz.quiz)) // Forza la conversione a String
                                .font(.headline)
                            Text("Punteggio: \(completedQuiz.totalScore)/\(completedQuiz.totalAnswers)")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        Spacer()
                        Text("\(completedQuiz.totalScore)")
                            .font(.headline)
                            .foregroundColor(.green)
                    }
                    .padding(.vertical, 5)
                }
            }
            .padding(.horizontal)
        }
    }
}

/*
#Preview {
    // Crea l'istanza di QuizManager
    let quizManager = QuizManager()

    // Crea l'istanza di QuizScore (Punteggio per il quiz attuale)
    let score = QuizScore(quiz: "Quiz Incroci", totalScore: 8, totalAnswers: 10)

    // Crea ScoreManager con score iniziale e quizManager
    let scoreManager = ScoreManager(score: score, currentScore: 8, quizManager: quizManager)

    // Aggiungi alcuni quiz completati per la visualizzazione
    scoreManager.completedQuizzes = [
        QuizScore(quiz: "Quiz Patente", totalScore: 8, totalAnswers: 10),
        QuizScore(quiz: "Quiz Sicurezza", totalScore: 7, totalAnswers: 10)
    ]

    // Restituisce la ScoreView con scoreManager come environmentObject
    return ScoreView()
        .environmentObject(scoreManager)
}
*/
