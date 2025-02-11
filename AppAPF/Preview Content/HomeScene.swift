import SwiftUI
import SpriteKit

// Creiamo una classe dedicata per la HomeScene
class HomeScene: SKScene {
    
    override func didMove(to view: SKView) {
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        let node = atPoint(location)
        
        if node.name == "carButton" {
            print("carButton tapped")
        }
        
        // Carica la nuova scena
        if let scene = LevelScene(fileNamed: "LevelScene") {
            scene.scaleMode = .aspectFill
            let transition = SKTransition.fade(withDuration: 0.5)
            view?.presentScene(scene, transition: transition)
        }
    }
}
