import SwiftUI
import SpriteKit

// Creiamo una classe dedicata per la HomeScene
class HomeSKScene: SKScene {
    var blueFlower: SKSpriteNode!
    
    override func didMove(to view: SKView) {
        blueFlower = childNode(withName: "blueFlower") as? SKSpriteNode
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        let node = atPoint(location)
        
        if node.name == "road" {
            print("Blue flower tapped!")
        }
    }
}
