import SwiftUI
import SpriteKit

struct LevelSceneView: View {
    @Binding var isInLevelScene: Bool  // Stato per tornare alla HomeView
    @State private var showExitConfirmation = false  // Stato per mostrare il popup

    var scene: SKScene? {
        guard let scene = SKScene(fileNamed: "LevelScene") else {
            print("⚠️ Error: Unable to load LevelScene.sks")
            return nil
        }
        scene.size = CGSize(width: 1170, height: 2532)
        scene.scaleMode = .aspectFill
        return scene
    }

    var body: some View {
        ZStack {
            if let scene = scene {
                SpriteView(scene: scene)
                    .ignoresSafeArea()
            } else {
                Text("Error loading the scene")
                    .foregroundColor(.red)
            }

            VStack {
                HStack {
                    Button(action: {
                        showExitConfirmation = true  // Mostra il popup di conferma
                    }) {
                        Image(systemName: "arrow.left.circle.fill")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .foregroundColor(.white)
                            .background(Circle().fill(Color.black.opacity(0.5)))
                    }
                    .padding(.leading, 20)
                    Spacer()
                }
                Spacer()
            }
        }
        .transition(.opacity)
        .alert("Are you sure you want to exit?", isPresented: $showExitConfirmation) {
            Button("Cancel", role: .cancel) { }
            Button("Exit", role: .destructive) {
                isInLevelScene = false  // Torna alla HomeView
            }
        }
    }
}

struct LevelSceneView_Previews: PreviewProvider {
    static var previews: some View {
        LevelSceneView(isInLevelScene: .constant(true))
    }
}
