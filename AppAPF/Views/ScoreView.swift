import SwiftUI

struct ScoreView: View {
    @EnvironmentObject var scoreManager: ScoreManager
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        
            
            NavigationView {
                ZStack { // Inizia ZStack per lo sfondo
                    Image("backv")
                        .resizable()
                        .scaledToFill()
                        .ignoresSafeArea()
                        
                ScrollView {
                    VStack{
                        Spacer()
                            .frame(height: 40)
                        /// QUIZ UNO - DA AGGIORNARE
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Quiz uno: \(scoreManager.score.quiz)")
                                .font(.title2)
                                .fontWeight(.semibold)
                            
                            //HStack per allineare il punteggio al tasto elimina
                            HStack {
                                Text("Punteggio: \(scoreManager.score.totalScore)/\(scoreManager.score.totalAnswers)")
                                    .font(.headline)
                                    .foregroundColor(.green)
                                Spacer()
                                
                                Button(action: {scoreManager.score.totalScore = 0
                                    scoreManager.saveScore()
                                }) {
                                    Image(systemName: "trash")
                                        .padding(.horizontal)
                                        .foregroundColor(.black)
                                    
                                }
                            } .padding(.bottom, 20)
                            
                            // Barra di progresso QUIZ UNO
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
                        .shadow(color: .black, radius: 3)
                        .padding(.horizontal)
                        
                        
                        /// QUIZ DUE - DA AGGIORNARE
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Quiz due: \(scoreManager.score.quiz)")
                                .font(.title2)
                                .fontWeight(.semibold)
                            
                            //HStack per allineare il punteggio al tasto elimina
                            HStack {
                                Text("Punteggio: \(scoreManager.score.totalScore)/\(scoreManager.score.totalAnswers)")
                                    .font(.headline)
                                    .foregroundColor(.green)
                                Spacer()
                                
                                Button(action: {scoreManager.score.totalScore = 0
                                    scoreManager.saveScore()
                                }) {
                                    Image(systemName: "trash")
                                        .padding(.horizontal)
                                        .foregroundColor(.black)
                                }
                            } .padding(.bottom, 20)
                            
                            // Barra di progresso quiz DUE
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
                        .shadow(color: .black, radius: 3)
                        .padding()
                        
                        
                        /// QUIZ TRE - DA AGGIORNARE
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Quiz tre: \(scoreManager.score.quiz)")
                                .font(.title2)
                                .fontWeight(.semibold)
                            
                            //HStack per allineare il punteggio al tasto elimina
                            HStack {
                                Text("Punteggio: \(scoreManager.score.totalScore)/\(scoreManager.score.totalAnswers)")
                                    .font(.headline)
                                    .foregroundColor(.green)
                                Spacer()
                                
                                Button(action: {scoreManager.score.totalScore = 0
                                    scoreManager.saveScore()
                                }) {
                                    Image(systemName: "trash")
                                        .padding(.horizontal)
                                        .foregroundColor(.black)
                                }
                            } .padding(.bottom, 20)
                            
                            // Barra di progresso QUIZ TRE
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
            .environmentObject(ScoreManager()) // Fornisci l'environment object!
    }
}
