import SpriteKit

class HomeScene: SKScene {
    
    var carButton: SKSpriteNode!
    var onCarButtonTapped: (() -> Void)?
    
    override func didMove(to view: SKView) {
        // Initialize and configure the car button
        carButton = SKSpriteNode(imageNamed: "carButton")
        carButton.name = "carButton"
        carButton.position = CGPoint(x: size.width / 2, y: size.height / 2)
        carButton.setScale(0.5)
        addChild(carButton)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        let node = atPoint(location)
        
        if node.name == "carButton" {
            print("carButton tapped")
            node.alpha = 0.5 // Rendi il pulsante trasparente mentre viene toccato
        }
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        let node = atPoint(location)

        // Check if the car button was tapped
        if node.name == "carButton" {
            print("🚗 Car button tapped")
            onCarButtonTapped?() // Trigger closure to transition to LevelScene
        }
    }

    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        carButton.alpha = 1.0 // Se il tocco viene annullato, ripristina la trasparenza
    }
}
