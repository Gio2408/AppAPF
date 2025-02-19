import SwiftUI

struct ErrorsView: View {
    @EnvironmentObject var errorManager: ErrorManager

    var body: some View {
        NavigationView {
            ZStack {
                Color(red: 0.65, green: 0.80, blue: 0.45)
                    .edgesIgnoringSafeArea(.all)

                VStack {
                    List {
                        ForEach(errorManager.errors) { error in
                            HStack(spacing: 20) {
                                VStack(alignment: .leading, spacing: 5) {
                                    Text(error.question)
                                        .font(.system(size: 20, weight: .bold, design: .rounded))
                                        .foregroundColor(.black)
                                        .lineLimit(nil)
                                         .fixedSize(horizontal: false, vertical: true)
                                     Spacer()
                                     Text("Correct Answer: \(error.correctAnswer)")
                                         .foregroundColor(.green)
                                         .fontWeight(.semibold)
                                         .font(.system(size: 18, design: .rounded))
                                     Text("Your Answer: \(error.userAnswer)")

                                         .foregroundColor(.red)
                                         .fontWeight(.semibold)
                                         .font(.system(size: 18, design: .rounded))
                                }
                            }
                            .padding(24)
                            .background(Color.white)
                            .shadow(color: .gray.opacity(0.3), radius: 4, x: 0, y: 2)
                            .cornerRadius(20)
                            .listRowBackground(Color.clear)
                        }
                        .onDelete { indices in
                            errorManager.errors.remove(atOffsets: indices)
                            errorManager.saveErrors()
                        }
                    }
                    .listStyle(PlainListStyle())
                              .padding(.horizontal, 16)
                              .background(Color.clear)
                              .scrollContentBackground(.hidden)
                }
                .navigationTitle("Mistakes")
                .onAppear {
                    errorManager.loadErrors()
                }
            }
        }
    }
}

struct ErrorsView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorsView()
            .environmentObject(ErrorManager())
    }
}
