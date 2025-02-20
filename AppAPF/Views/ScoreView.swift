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
                        Spacer()
                            .frame(height: 40)

                        /// QUIZ ONE - TO UPDATE
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Quiz: \(scoreManager.score.quiz)")
                                .font(.title2)
                                .fontWeight(.semibold)
                                .foregroundColor(.black)

                            // HStack to align the score with the delete button
                            HStack {
                                Text("Score: \(scoreManager.score.totalScore)/\(scoreManager.score.totalAnswers)")
                                    .font(.headline)
                                    .foregroundColor(.green)
                                Spacer()

                                Button(action: {
                                    scoreManager.score.totalScore = 0
                                    scoreManager.saveScore()
                                }) {
                                    Image(systemName: "trash")
                                        .padding(.horizontal)
                                        .foregroundColor(.black)
                                }
                            }
                            .padding(.bottom, 20)

                            // Progress bar QUIZ ONE
                            ProgressView(value: Double(scoreManager.score.totalScore), total: Double(scoreManager.score.totalAnswers))
                                .progressViewStyle(LinearProgressViewStyle())
                                .padding(.bottom, 20)
                            Text("\(scoreManager.score.totalScore*2)/\(scoreManager.score.totalAnswers*2) XP")
                                .foregroundColor(.blue)
                                .font(.title3)
                                .fontWeight(.black)
                                .frame(maxWidth: .infinity)
                        }
                        .padding()
                        .background(Color.white.opacity(0.9))
                        .cornerRadius(15)
                        .padding(.horizontal)

                        /// QUIZ TWO - TO UPDATE
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Warning lights: \(scoreManager.WarningScore.quiz)")
                                .font(.title2)
                                .fontWeight(.semibold)
                                .foregroundColor(.black)

                            // HStack to align the score with the delete button
                            HStack {
                                Text("Score: \(scoreManager.WarningScore.totalScore)/\(scoreManager.WarningScore.totalAnswers)")
                                    .font(.headline)
                                    .foregroundColor(.green)
                                Spacer()

                                Button(action: {
                                    scoreManager.WarningScore.totalScore = 0
                                    scoreManager.saveWarningScore()
                                }) {
                                    Image(systemName: "trash")
                                        .padding(.horizontal)
                                        .foregroundColor(.black)
                                }
                            }
                            .padding(.bottom, 20)

                            // Progress bar QUIZ TWO
                            ProgressView(value: Double(scoreManager.WarningScore.totalScore), total: Double(scoreManager.WarningScore.totalAnswers))
                                .progressViewStyle(LinearProgressViewStyle())
                                .padding(.bottom, 20)
                            Text("\(scoreManager.WarningScore.totalScore*2)/\(scoreManager.WarningScore.totalAnswers*2) XP")
                                .foregroundColor(.blue)
                                .font(.title3)
                                .fontWeight(.black)
                                .frame(maxWidth: .infinity)
                        }
                        .padding()
                        .background(Color.white.opacity(0.9))
                        .cornerRadius(15)
                        .padding()

                        
                    }
                    
                }
                .navigationTitle("Score")
            }
            .background(Color.clear)
        }.onAppear {
            scoreManager.loadScore()
            scoreManager.loadAnswers()
            scoreManager.loadWarningScore()
            scoreManager.loadWarningAnswers()
        }
    }
}

struct ScoreView_Previews: PreviewProvider {
    static var previews: some View {
        ScoreView()
            .environmentObject(ScoreManager()) // Provide the environment object!
    }
}
