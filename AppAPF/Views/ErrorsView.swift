import SwiftUI

struct ErrorsView: View {
    @EnvironmentObject var errorManager: ErrorManager

    var body: some View {
        NavigationView {
            ZStack {
                Color(red: 0.65, green: 0.80, blue: 0.45)
                    .edgesIgnoringSafeArea(.all)

                ScrollView {
                    VStack(spacing: 15) {

                        // Quiz Time Section
                        sectionHeader(title: "True or False Quiz", imageName: "quizButton", count: errorManager.errors.count)

                        // Quiz Time Errors List
                        List {
                            ForEach(errorManager.errors) { error in
                                errorRow(error: error)
                            }
                            .onDelete { indices in
                                errorManager.errors.remove(atOffsets: indices)
                                errorManager.saveErrors()
                            }
                            .listRowBackground(Color.clear)
                        }
                        .listStyle(PlainListStyle())
                        .frame(height: CGFloat(errorManager.errors.count) * 120) // Consider using a dynamic height calculation if the row height changes
                        .scrollContentBackground(.hidden)

                        // Warning Lights Section
                        sectionHeader(title: "Warning Lights", imageName: "carLights", count: errorManager.lightErrors.count)
                            .padding(.top, 35)

                        // Warning Lights Errors List
                        List {
                            ForEach(errorManager.lightErrors) { error in
                                errorRow2(error: error)
                            }
                            .onDelete { indices in
                                errorManager.lightErrors.remove(atOffsets: indices)
                                errorManager.saveWarningErrors()
                            }
                            .listRowBackground(Color.clear)
                        }
                        .listStyle(PlainListStyle())
                        .frame(height: CGFloat(errorManager.lightErrors.count) * 120) // Consider using a dynamic height calculation if the row height changes
                        .scrollContentBackground(.hidden)

                    }
                    .padding(.vertical, 20)
                }
                .navigationTitle("Mistakes")
                .onAppear {
                    errorManager.loadErrors()
                    errorManager.loadWarningErrors()
                }
            }
        }
    }

    // Section Header Component (title + image + error count)
    private func sectionHeader(title: String, imageName: String, count: Int) -> some View {
        VStack {
            HStack {
                Image(imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)

                Text(title)
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }
            .padding()

            Text("Number of mistakes: \(count)")
                .padding(.vertical, 5)
                .frame(maxWidth: .infinity, alignment: .center)
                .foregroundColor(.white)
                .background(Color.black.opacity(0.5))
                .fontWeight(.black)
                .font(.title3)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.white.opacity(0.9))
        .cornerRadius(15)
        .padding(.horizontal, 23)
    }

    // Error Row Component
    private func errorRow(error: QuizError) -> some View {
        HStack(spacing: 20) {
            VStack(alignment: .leading, spacing: 5) {
                Text(error.question)
                    .font(.system(size: 20, weight: .bold, design: .rounded))
                    .foregroundColor(.black)
                    .lineLimit(nil)
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(.bottom, 10)
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
        .padding()
        .background(Color.white)
        .cornerRadius(20)
        .padding(.horizontal, 16)
    }

    private func errorRow2(error: QuizError) -> some View {
        HStack(spacing: 20) {
            VStack(alignment: .leading, spacing: 5) {
                Text(error.question)
                    .font(.system(size: 20, weight: .bold, design: .rounded))
                    .foregroundColor(.black)
                    .lineLimit(nil)
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(.bottom, 10)

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
        .padding()
        .background(Color.white)
        .cornerRadius(20)
        .padding(.horizontal, 16)
    }
}

struct ErrorsView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorsView()
            .environmentObject(ErrorManager())
    }
}
