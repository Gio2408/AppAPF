//  ErrorsView.swift
//  AppAPF
//  Created by Michele Vassallo Todaro on 10/02/25.


import SwiftUI

struct ErrorsView: View {
    @EnvironmentObject var errorManager: ErrorManager // Access to the errorManager object
    //@Binding var isInErrorsView: Bool // Binding to control the state of this view

    var body: some View {
        NavigationView {
            ZStack (alignment: .bottomTrailing){
                VStack {
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
                .navigationTitle("Saved Errors") // Title for the navigation bar
                Button(action: { errorManager.errors.removeAll()
                }) {
                    Image(systemName: "trash")
                        .font(.largeTitle)
                        .foregroundColor(.black)
                        .frame(width: 50, height: 50)
                }

                .background(Color.white.opacity(0.9))
                .cornerRadius(22)
                .shadow(color: .black, radius: 3)
                .padding()
                
            }
        }
    }
}


// Example preview of the ErrorsView

struct ErrorsView_Previews: PreviewProvider {
    static var previews: some View {
        // Creo degli errori inventati
        let errorManager = ErrorManager()
        errorManager.errors = [
            QuizError(question: "Incrocio numero: 3", correctAnswer: "wait", userAnswer: "Go"),
            //poi mettiamo una variabile che si collega a QuizView
            QuizError(question: "Incrocio numero X", correctAnswer: "Go", userAnswer: "wait"),
            QuizError(question: "Incrocio numero: 3", correctAnswer: "wait", userAnswer: "Go"),
            //poi mettiamo una variabile che si collega a QuizView
            QuizError(question: "Incrocio numero X", correctAnswer: "Go", userAnswer: "wait"),
            QuizError(question: "Incrocio numero: 3", correctAnswer: "wait", userAnswer: "Go"),
            //poi mettiamo una variabile che si collega a QuizView
            QuizError(question: "Incrocio numero X", correctAnswer: "Go", userAnswer: "wait")
        ]
        
        return ErrorsView()
            .environmentObject(errorManager)
    }
}
