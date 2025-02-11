import SwiftUI
import SpriteKit

struct LevelSceneView: View {
    @Binding var isInLevelScene: Bool  // Stato per tornare indietro

    var scene: SKScene? {
        guard let scene = SKScene(fileNamed: "LevelScene") else {
            print("⚠️ Errore: Impossibile caricare LevelScene.sks")
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
                Text("Errore nel caricamento della scena")
                    .foregroundColor(.red)
            }

            VStack {
                HStack {
                    Button(action: {
                        isInLevelScene = false  // Torna alla HomeSceneView
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
    }
}

struct LevelSceneView_Previews: PreviewProvider {
    static var previews: some View {
        LevelSceneView(isInLevelScene: .constant(true))
    }
}
