//
//  ErrorsView.swift
//  AppAPF
//
//  Created by Michele Vassallo Todaro on 10/02/25.
//
//  la UI l'ho fatta al volo, non so quale sarà l'estetica finale

import SwiftUI

struct ErrorsView: View {
    @EnvironmentObject var errorManager: ErrorManager

    var body: some View {
        NavigationView {
            VStack {
                Button("Elimina") {
                    errorManager.errors.removeAll()
                }
                List {
                    ForEach(errorManager.errors) { error in
                        VStack(alignment: .leading) {
                            Text(error.question)
                                .font(.headline)
                            Text("Risposta corretta: \(error.correctAnswer)")
                                .foregroundColor(.green)
                            Text("Tua risposta: \(error.userAnswer)")
                                .foregroundColor(.red)
                        }
                        .padding()
                    }
                }
            }
            .navigationTitle("Errori Salvati")
        }
    }
}


//esempio di view

struct ErrorsView_Previews: PreviewProvider {
    static var previews: some View {
        // Creo degli errori inventati
        let errorManager = ErrorManager()
        errorManager.errors = [
            QuizError(question: "Incrocio numero: 3", correctAnswer: "wait", userAnswer: "Go"),
            //poi mettiamo una variabile che si collega a QuizView
            QuizError(question: "Incrocio numero X", correctAnswer: "Go", userAnswer: "wait")
        ]
        
        return ErrorsView()
            .environmentObject(errorManager)
    }
}

