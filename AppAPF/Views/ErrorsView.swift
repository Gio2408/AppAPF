//  ErrorsView.swift
//  AppAPF
//  Created by Michele Vassallo Todaro on 10/02/25.


import SwiftUI

struct ErrorsView: View {
    @EnvironmentObject var errorManager: ErrorManager // Access to the errorManager object

    var body: some View {
        NavigationView {
            ZStack (alignment: .bottomTrailing){
                Image("backv")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                ScrollView{
                    VStack (alignment: .leading){
                        Spacer()
                            .frame(height: 40)
                            ForEach(errorManager.errors) { error in
                                VStack(alignment: .leading) {
                                    Text(error.question)
                                        .font(.headline)
                                        .foregroundColor(.black)
                                    Spacer()
                                    Text("Risposta corretta: \(error.correctAnswer)")
                                        .foregroundColor(.green)
                                    Spacer()
                                    Text("Tua risposta: \(error.userAnswer)")
                                        .foregroundColor(.red)
                                    Spacer()
                                }
                                .padding() //spazia dentro il quadrato
                            }
                        
                            .padding() //spazia dentro il quadrato ancora di più
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(Color.white.opacity(0.9))
                            .cornerRadius(15)
                            .shadow(color: .black, radius: 3)
                            
                            .padding(.horizontal, 23) //spazia dopo il quadrato
                            .padding(.vertical, 1)
                        
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    .onAppear {
                        errorManager.loadErrors()
                    }
                }
                Button(action: { errorManager.errors.removeAll()
                    errorManager.saveErrors()
                }) {
                    Image(systemName: "trash")
                        .font(.largeTitle)
                        .foregroundColor(.black)
                        .frame(width: 50, height: 50)
                }
                
                .background(Color.white.opacity(0.9))
                .cornerRadius(22)
                .shadow(color: .black, radius: 3)
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 5))
                .padding()
                
                
            }
            .navigationTitle("Mistakes")
        }
        
    }
}
