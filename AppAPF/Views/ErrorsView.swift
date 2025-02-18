import SwiftUI

struct ErrorsView: View {
    @EnvironmentObject var errorManager: ErrorManager
    
    var body: some View {
        NavigationView {
            ZStack {
                // Sfondo verde chiaro per un look più giocoso
                ZStack(alignment: .leading){
                    Image("backv")
                        .resizable()
                        .scaledToFill()
                        .ignoresSafeArea()
                    
                    ScrollView{
                        VStack { ///VStack che controlla gli errori di un solo quiz
                            Spacer()
                                .frame(height: 40)
                            VStack{
                                HStack{
                                    Image("quizButton")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 50, height: 50, alignment: .leading)
                                        
                                    
                                    Text("Quiz Time")
                                        .font(.title)
                                        .fontWeight(.bold)
                                        .frame(maxWidth: .infinity, alignment: .trailing)
                                }
                                .padding()
                                
                                Text("Numer of mistakes:\t \(errorManager.errors.count)")
                                    .padding(.horizontal, 15)
                                    .padding(.vertical, 5)
                                    .frame(maxWidth: .infinity, alignment: .center)
                                    .foregroundStyle(Color.white)
                                    .background(Color.red)
                                    .cornerRadius(15)
                                    .fontWeight(.semibold)
                                    .font(.title2)
                                    //.shadow(color: .black, radius: 2)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(Color.white.opacity(0.9))
                            .cornerRadius(15)
                            .shadow(color: .black, radius: 4, x: 0, y: 5)
                            .padding(.horizontal, 23) //spazia dopo il quadrato
                            .padding(.vertical, 1)
                            
                            ForEach(errorManager.errors) { error in
                                HStack{
                                    VStack(alignment: .leading, spacing: 8) {
                                        Text(error.question)
                                            .font(.system(size: 20, weight: .bold, design: .rounded))
                                            .foregroundColor(.black)
                                        HStack {
                                            Text("✅ Risposta corretta: \(error.correctAnswer)")
                                                .foregroundColor(.green)
                                                .font(.system(size: 18, design: .rounded))
                                            
                                            Text("❌ Tua risposta: \(error.userAnswer)")
                                                .foregroundColor(.red)
                                                .font(.system(size: 18, design: .rounded))
                                        }
                                    }
                                }
                                .padding()
                                .background(Color.white.opacity(0.9))
                                .cornerRadius(20)
                                .shadow(color: .gray.opacity(0.3), radius: 4, x: 0, y: 2)
                                .padding(.leading, 40)
                                .padding(.trailing, 10)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                
                                
                                
                            }
                            .onDelete { indices in
                                errorManager.errors.remove(atOffsets: indices)
                                errorManager.saveErrors()
                            }
                            .listStyle(PlainListStyle()) // Per mantenere l'aspetto senza bordi
                            .padding(.horizontal, 16)
                        }
                        
                        VStack { ///VStack che controlla gli errori di un solo quiz
                            Spacer()
                                .frame(height: 40)
                            VStack{
                                HStack{
                                    Image("carLights")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 50, height: 50, alignment: .leading)
                                        
                                    
                                    Text("Warning Lights")
                                        .font(.title)
                                        .fontWeight(.bold)
                                        .frame(maxWidth: .infinity, alignment: .trailing)
                                }
                                .padding()
                                
                                Text("Numer of mistakes:\t \(errorManager.errors.count)")
                                    .padding(.horizontal, 15)
                                    .padding(.vertical, 5)
                                    .frame(maxWidth: .infinity, alignment: .center)
                                    .foregroundStyle(Color.white)
                                    .background(Color.red)
                                    .cornerRadius(15)
                                    .fontWeight(.semibold)
                                    .font(.title2)
                                    //.shadow(color: .black, radius: 2)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(Color.white.opacity(0.9))
                            .cornerRadius(15)
                            .shadow(color: .black, radius: 4, x: 0, y: 5)
                            .padding(.horizontal, 23) //spazia dopo il quadrato
                            .padding(.vertical, 1)
                            
                            ForEach(errorManager.errors) { error in
                                HStack{
                                    VStack(alignment: .leading, spacing: 8) {
                                        Text(error.question)
                                            .font(.system(size: 20, weight: .bold, design: .rounded))
                                            .foregroundColor(.black)
                                        HStack {
                                            Text("✅ Risposta corretta: \(error.correctAnswer)")
                                                .foregroundColor(.green)
                                                .font(.system(size: 18, design: .rounded))
                                            
                                            Text("❌ Tua risposta: \(error.userAnswer)")
                                                .foregroundColor(.red)
                                                .font(.system(size: 18, design: .rounded))
                                        }
                                    }
                                }
                                .padding()
                                .background(Color.white.opacity(0.9))
                                .cornerRadius(20)
                                .shadow(color: .gray.opacity(0.3), radius: 4, x: 0, y: 2)
                                .padding(.leading, 40)
                                .padding(.trailing, 10)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                
                                
                                
                            }
                            .onDelete { indices in
                                errorManager.errors.remove(atOffsets: indices)
                                errorManager.saveErrors()
                            }
                            .listStyle(PlainListStyle()) // Per mantenere l'aspetto senza bordi
                            .padding(.horizontal, 16)
                        }
                        
                    }
                    .navigationTitle("Mistakes")
                    .onAppear {
                        errorManager.loadErrors()
                    }
                }
            }
        }
    }
}
