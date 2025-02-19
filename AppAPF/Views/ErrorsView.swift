import SwiftUI

struct ErrorsView: View {
    @EnvironmentObject var errorManager: ErrorManager
    
    var body: some View {
        NavigationView {
            ZStack {
                // This is the background
                ZStack(alignment: .leading){
                    Image("backv")
                        .resizable()
                        .scaledToFill()
                        .ignoresSafeArea()
                    
                    ScrollView{
                        VStack { /// This VStack is used to create the section with the name of the quiz and its errors
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
                                    VStack(alignment: .leading, spacing: 8) {
                                        Text(error.question)
                                            .font(.system(size: 20, weight: .bold, design: .rounded))
                                            .foregroundColor(.black)

                                        HStack(spacing: 20){
                                            if error.userAnswer == "T" {
                                                Image(systemName: "person.fill")
                                                    .padding(.leading, 31)
                                                
                                                Text("T")
                                                    .font(.title3)
                                                    .foregroundColor(.white)
                                                    .frame(width: 50, height: 50)
                                                    .background(Color.red)
                                                    .cornerRadius(10)

                                                Text("F")
                                                    .font(.title3)
                                                    .foregroundColor(.white)
                                                    .frame(width: 50, height: 50)
                                                    .background(Color.green)
                                                    .cornerRadius(10)
                                            } else {
                                                
                                                Text("T")
                                                    .font(.title3)
                                                    .foregroundColor(.white)
                                                    .frame(width: 50, height: 50)
                                                    .background(Color.green)
                                                    .cornerRadius(10)
                                                    .padding(.leading, 69)
                                                
                                                Text("F")
                                                    .font(.title3)
                                                    .foregroundColor(.white)
                                                    .frame(width: 50, height: 50)
                                                    .background(Color.red)
                                                    .cornerRadius(10)
                                                    
                                                
                                                Image(systemName: "person.fill")
                                                
                                                
                                            }
                                        }
                                        
                                }
                                
                                .padding()
                                .background(Color.white.opacity(0.9))
                                .cornerRadius(20)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .shadow(color: .gray.opacity(0.3), radius: 4, x: 0, y: 2)
                                .padding(.leading, 40)
                                .padding(.trailing, 10)
                                
                            }
                            .onDelete { indices in
                                errorManager.errors.remove(atOffsets: indices)
                                errorManager.saveErrors()
                            }
                            .listStyle(PlainListStyle())
                            .padding(.horizontal, 16)
                        }
                        
                        VStack { /// This VStack is used to create the section with the name of the quiz and its errors
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
                                    VStack(alignment: .leading, spacing: 8) {
                                        Text(error.question)
                                            .font(.system(size: 20, weight: .bold, design: .rounded))
                                            .foregroundColor(.black)

                                        HStack(spacing: 20){
                                            if error.userAnswer == "T" {
                                                Image(systemName: "person.fill")
                                                    .padding(.leading, 31)
                                                
                                                Text("T")
                                                    .font(.title3)
                                                    .foregroundColor(.white)
                                                    .frame(width: 50, height: 50)
                                                    .background(Color.red)
                                                    .cornerRadius(10)

                                                Text("F")
                                                    .font(.title3)
                                                    .foregroundColor(.white)
                                                    .frame(width: 50, height: 50)
                                                    .background(Color.green)
                                                    .cornerRadius(10)
                                            } else {
                                                
                                                Text("T")
                                                    .font(.title3)
                                                    .foregroundColor(.white)
                                                    .frame(width: 50, height: 50)
                                                    .background(Color.green)
                                                    .cornerRadius(10)
                                                    .padding(.leading, 69)
                                                
                                                Text("F")
                                                    .font(.title3)
                                                    .foregroundColor(.white)
                                                    .frame(width: 50, height: 50)
                                                    .background(Color.red)
                                                    .cornerRadius(10)
                                                    
                                                
                                                Image(systemName: "person.fill")
                                                
                                                
                                            }
                                        }
                                        
                                }
                                
                                .padding()
                                .background(Color.white.opacity(0.9))
                                .cornerRadius(20)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .shadow(color: .gray.opacity(0.3), radius: 4, x: 0, y: 2)
                                .padding(.leading, 40)
                                .padding(.trailing, 10)
                                
                            }
                            .onDelete { indices in
                                errorManager.errors.remove(atOffsets: indices)
                                errorManager.saveErrors()
                            }
                            .listStyle(PlainListStyle())
                            .padding(.horizontal, 16)
                        }
                        
                    }
                    .navigationTitle("Mistakes")
                    .onAppear {
                        errorManager.loadErrors()
                    }

                    ForEach(errorManager.lightErrors) { error in
                        HStack(spacing: 12) {
                            Image(systemName: "exclamationmark.triangle.fill")
                                .foregroundColor(.yellow)
                                .font(.title)
                            
                            VStack(alignment: .leading, spacing: 8) {
                                Text(error.question)
                                    .font(.system(size: 20, weight: .bold, design: .rounded))
                                    .foregroundColor(.white)
                                
                                Text("✅ Correct answer: \(error.correctAnswer)")
                                    .foregroundColor(.green)
                                    .font(.system(size: 18, design: .rounded))
                                
                                Text("❌ Your answer: \(error.userAnswer)")
                                    .foregroundColor(.red)
                                    .font(.system(size: 18, design: .rounded))
                            }
                        }
                        .padding()
                        .background(Color.white.opacity(0.9))
                        .cornerRadius(20)
                        .shadow(color: .gray.opacity(0.3), radius: 4, x: 0, y: 2)
                    }
                    .onDelete { indices in
                        errorManager.errors.remove(atOffsets: indices)
                        errorManager.saveErrors()
                    }
                }

                    .listStyle(PlainListStyle()) // Keeps the appearance without borders
                    .padding(.horizontal, 16)
                }
            }
        }
    }

