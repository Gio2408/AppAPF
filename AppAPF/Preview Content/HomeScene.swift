import SpriteKit

class HomeScene: SKScene {
    var carButton: SKSpriteNode!
    var onCarButtonTapped: (() -> Void)? // Closure per comunicare con SwiftUI

    override func didMove(to view: SKView) {
        carButton = SKSpriteNode(imageNamed: "carButton")
        carButton.name = "carButton"
        carButton.position = CGPoint(x: size.width / 2, y: size.height / 2)
        carButton.setScale(0.5) // Riduci dimensione se necessario
        addChild(carButton)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        let node = atPoint(location)

        if node.name == "carButton" {
            onCarButtonTapped?() // Chiamata alla closure per passare a LevelScene
        }
    }
}
