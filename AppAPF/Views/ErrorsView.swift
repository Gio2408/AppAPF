//
//  ErrorsView.swift
//  AppAPF
//
//  Created by Michele Vassallo Todaro on 10/02/25.
//
//  la UI l'ho fatta al volo, non so quale sarà l'estetica finale

import SwiftUI

struct ErrorsView: View {
    @EnvironmentObject var errorManager: ErrorManager // Access to the errorManager object
    @Binding var isInErrorsView: Bool // Binding to control the state of this view

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    // Back button to return to the previous screen
                    Button(action: {
                        withAnimation {
                            isInErrorsView = false // Go back to the previous screen
                        }
                    }) {
                        Image(systemName: "arrow.backward")
                            .font(.title)
                            .foregroundColor(.blue) // Blue color for the back button
                    }
                    Spacer()
                }
                .padding()

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
            }
            .navigationTitle("Saved Errors") // Title for the navigation bar
        }
    }
}

// Example preview of the ErrorsView

struct ErrorsView_Previews: PreviewProvider {
    static var previews: some View {
        // Create some sample errors
        let errorManager = ErrorManager()
        errorManager.errors = [
            QuizError(question: "Intersection number: 3", correctAnswer: "wait", userAnswer: "Go"),
            // You can later link this to the QuizView variable
            QuizError(question: "Intersection number X", correctAnswer: "Go", userAnswer: "wait")
        ]
        
        return ErrorsView(isInErrorsView: .constant(true))
            .environmentObject(errorManager)
    }
}
