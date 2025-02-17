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
                                Text(error.question) // Question
                                    .font(.headline)
                                Text("Correct Answer: \(error.correctAnswer)") // Correct Answer
                                    .foregroundColor(.green)
                                Text("Your Answer: \(error.userAnswer)") // Your Answer
                                    .foregroundColor(.red)
                            }
                            .padding()
                            
                        }
                    }
                }
                .navigationTitle("Saved Errors") // Saved Errors
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
        let errorManager = ErrorManager()
        errorManager.errors = [
            QuizError(question: "Intersection number: 3", correctAnswer: "wait", userAnswer: "Go"),
            QuizError(question: "Intersection number X", correctAnswer: "Go", userAnswer: "wait"),
            QuizError(question: "Intersection number: 3", correctAnswer: "wait", userAnswer: "Go"),
            QuizError(question: "Intersection number X", correctAnswer: "Go", userAnswer: "wait"),
            QuizError(question: "Intersection number: 3", correctAnswer: "wait", userAnswer: "Go"),
            QuizError(question: "Intersection number X", correctAnswer: "Go", userAnswer: "wait")
        ]
        
        return ErrorsView()
            .environmentObject(errorManager)
    }
}
