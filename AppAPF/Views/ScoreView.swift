import SwiftUI

struct ScoreView: View {
    @EnvironmentObject var scoreManager: ScoreManager
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView {
            ZStack {
                Image("road2")
                    .resizable()
                    .scaledToFill()
                    .blur(radius: 5)
                    .ignoresSafeArea()
                ScrollView {
                    VStack {
                        Spacer()
                            .frame(height: 90)
                        // QUIZ ONE - TO BE UPDATED
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Quiz one: \(scoreManager.score.quiz)")
                                .font(.title2)
                                .fontWeight(.semibold)
                            
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
                            }.padding(.bottom, 20)
                            
                            // Progress bar QUIZ ONE
                            ProgressView(value: Double(scoreManager.score.totalScore), total: Double(scoreManager.score.totalAnswers))
                                .progressViewStyle(LinearProgressViewStyle())
                                .padding(.bottom, 20)
                        }
                        .padding()
                        .background(Color.white.opacity(0.9))
                        .cornerRadius(10)
                        .shadow(color: .black, radius: 3)
                        .padding()
                        
                        
                        // QUIZ TWO - TO BE UPDATED
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Quiz two: \(scoreManager.score.quiz)")
                                .font(.title2)
                                .fontWeight(.semibold)
                            
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
                            }.padding(.bottom, 20)
                            
                            // Progress bar quiz TWO
                            ProgressView(value: Double(scoreManager.score.totalScore), total: Double(scoreManager.score.totalAnswers))
                                .progressViewStyle(LinearProgressViewStyle())
                                .padding(.bottom, 20)
                        }
                        .padding()
                        .background(Color.white.opacity(0.9))
                        .cornerRadius(10)
                        .shadow(color: .black, radius: 3)
                        .padding()
                        
                        
                        // QUIZ THREE - TO BE UPDATED
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Quiz three: \(scoreManager.score.quiz)")
                                .font(.title2)
                                .fontWeight(.semibold)
                            
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
                            }.padding(.bottom, 20)
                            
                            // Progress bar QUIZ THREE
                            ProgressView(value: Double(scoreManager.score.totalScore), total: Double(scoreManager.score.totalAnswers))
                                .progressViewStyle(LinearProgressViewStyle())
                                .padding(.bottom, 20)
                        }
                        .padding()
                        .background(Color.white.opacity(0.9))
                        .cornerRadius(10)
                        .shadow(color: .black, radius: 3)
                        .padding()
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
