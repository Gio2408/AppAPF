//  ErrorsView.swift
//  AppAPF
//  Created by Michele Vassallo Todaro on 10/02/25.


import SwiftUI

struct ErrorsView: View {
    @EnvironmentObject var errorManager: ErrorManager // Access to the errorManager object
    //@Binding var isInErrorsView: Bool // Binding to control the state of this view

    var body: some View {
        NavigationView {
            
            // List to display all errors
            List {
                ForEach(errorManager.errors) { error in
                    VStack(alignment: .leading) {
                        Text(error.question)
                            .font(.headline) // Display the question in a bold font
                        Text("Correct Answer: \(error.correctAnswer)")
                            .foregroundColor(.green) // Green color for the correct answer
                        Text("Your Answer: \(error.userAnswer)")
                            .foregroundColor(.red) // Red color for the user's answer
                    }
                    .padding()
                }
            }
            .navigationTitle("Saved Errors") // Title for the navigation bar
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
            QuizError(question: "Incrocio numero X", correctAnswer: "Go", userAnswer: "wait")
        ]
        
        return ErrorsView()
            .environmentObject(errorManager)
    }
}
