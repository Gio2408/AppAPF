import SpriteKit

class HomeScene: SKScene {
    var carButton: SKSpriteNode!
    var onCarButtonTapped: (() -> Void)?  // Callback per SwiftUI

    override func didMove(to view: SKView) {
        carButton = childNode(withName: "carButton") as? SKSpriteNode
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        let node = atPoint(location)

        if node.name == "carButton" {
            print("carButton tapped")
            onCarButtonTapped?()  // Chiama SwiftUI per cambiare scena
        }
    }
}
