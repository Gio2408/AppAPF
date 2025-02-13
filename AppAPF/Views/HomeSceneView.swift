import SwiftUI
import SpriteKit

struct HomeSceneView: View {
    @Binding var isInLevelScene: Bool  // Controllo per LevelScene
    @State private var isVisible: Bool = false  // Stato per l'animazione fade-in

    var scene: HomeScene {
        let scene = HomeScene(fileNamed: "HomeScene")!
        scene.scaleMode = .aspectFill
        scene.onCarButtonTapped = {
            withAnimation(.easeInOut(duration: 0.5)) {
                isInLevelScene = true  // Cambia la scena in SwiftUI
            }
        }
        return scene
    }

    var body: some View {
        SpriteView(scene: scene)
            .ignoresSafeArea()
            .opacity(isVisible ? 1 : 0)  // Opacità iniziale 0, poi diventa 1
            .onAppear {
                withAnimation(.easeInOut(duration: 0.5)) {
                    isVisible = true  // Attiva l'animazione fade-in
                }
            }
    }
}
