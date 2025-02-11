import SwiftUI
import SpriteKit

struct HomeSceneView: View {
    @Binding var isInLevelScene: Bool  // Controllo per LevelScene

    var scene: HomeScene {
        let scene = HomeScene(fileNamed: "HomeScene")!
        scene.scaleMode = .aspectFill
        scene.onCarButtonTapped = {
            isInLevelScene = true  // Cambia la scena in SwiftUI
        }
        return scene
    }

    var body: some View {
        SpriteView(scene: scene)
            .ignoresSafeArea()
    }
}

