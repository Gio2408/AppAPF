import SwiftUI

struct ScoreView: View {
    @EnvironmentObject var scoreManager: ScoreManager
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView {
            ZStack { // Background ZStack
                Color(red: 0.65, green: 0.80, blue: 0.45)
                    .edgesIgnoringSafeArea(.all)

                ScrollView {
                    VStack {
                        // QUIZ TWO - TO UPDATE
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Quiz: \(scoreManager.score1.quiz)")
                                .font(.title2)
                                .fontWeight(.semibold)
                                .foregroundColor(.black)

                            // HStack to align the score with the delete button
                            HStack {
                                Text("Score: \(scoreManager.score1.totalScore)/\(scoreManager.score1.totalAnswers)")
                                    .font(.headline)
                                    .foregroundColor(.green)
                                Spacer()

                                Button(action: {
                                    scoreManager.score1.totalScore = 0
                                    scoreManager.saveScore()
                                }) {
                                    Image(systemName: "trash")
                                        .padding(.horizontal)
                                        .foregroundColor(.black)
                                }
                            }
                            .padding(.bottom, 20)

                            // Progress bar QUIZ TWO
                            ProgressView(value: Double(scoreManager.score1.totalScore), total: Double(scoreManager.score1.totalAnswers))
                                .progressViewStyle(LinearProgressViewStyle())
                                .padding(.bottom, 20)
                            Text("\(scoreManager.score1.totalScore*2)/\(scoreManager.score1.totalAnswers*2) XP")
                                .foregroundColor(.blue)
                                .font(.title3)
                                .fontWeight(.black)
                                .frame(maxWidth: .infinity)
                        }
                        .padding()
                        .background(Color.white.opacity(0.9))
                        .cornerRadius(15)
                        .shadow(color: .black, radius: 3)
                        .padding()

                        // QUIZ THREE - TO UPDATE
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Dashboard lights: \(scoreManager.score2.quiz)")
                                .font(.title2)
                                .fontWeight(.semibold)
                                .foregroundColor(.black)

                            // HStack to align the score with the delete button
                            HStack {
                                Text("Score: \(scoreManager.score2.totalScore)/\(scoreManager.score2.totalAnswers)")
                                    .font(.headline)
                                    .foregroundColor(.green)
                                Spacer()

                                Button(action: {
                                    scoreManager.score2.totalScore = 0
                                    scoreManager.saveScore()
                                }) {
                                    Image(systemName: "trash")
                                        .padding(.horizontal)
                                        .foregroundColor(.black)
                                }
                            }
                            .padding(.bottom, 20)

                            // Progress bar QUIZ THREE
                            ProgressView(value: Double(scoreManager.score2.totalScore), total: Double(scoreManager.score2.totalAnswers))
                                .progressViewStyle(LinearProgressViewStyle())
                                .padding(.bottom, 20)
                            Text("\(scoreManager.score2.totalScore*2)/\(scoreManager.score2.totalAnswers*2) XP")
                                .foregroundColor(.blue)
                                .font(.title3)
                                .fontWeight(.black)
                                .frame(maxWidth: .infinity)
                        }
                        .padding()
                        .background(Color.white.opacity(0.9))
                        .cornerRadius(15)
                        .shadow(color: .black, radius: 3)
                        .padding(.horizontal)
                    }
                    .onAppear {
                        scoreManager.loadScore()
                        scoreManager.loadAnswers()
                    }
                }
                .navigationTitle("Score")
            }
            .background(Color.clear)
        }
    }
}

struct ScoreView_Previews: PreviewProvider {
    static var previews: some View {
        ScoreView()
            .environmentObject(ScoreManager()) // Provide the environment object!
    }
}
