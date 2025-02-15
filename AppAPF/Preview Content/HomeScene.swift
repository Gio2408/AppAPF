import SpriteKit
import SwiftUI

class HomeScene: SKScene {
    var road = SKSpriteNode()
    var carButton = SKSpriteNode()
    var quizButton = SKSpriteNode()
    
    var onCarButtonTapped: (() -> Void)? // Closure per comunicare con SwiftUI
    
    override func didMove(to view: SKView) {
        road = childNode(withName: "road") as! SKSpriteNode
        carButton = road.childNode(withName: "carButton") as! SKSpriteNode
        quizButton = road.childNode(withName: "quizButton") as! SKSpriteNode
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        let node = atPoint(location)
        
        if node == carButton {
            carButton.alpha = 0.5 // Rendi semi trasparente quando premuto
            run(SKAction.playSoundFileNamed("car-engine.mp3", waitForCompletion: false))
        }
        
        if node == quizButton {
            quizButton.alpha = 0.5 // Rendi semi trasparente quando premuto
        }

    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        let node = atPoint(location)
        
        // Ripristina l'opacità
        carButton.alpha = 1.0
        quizButton.alpha = 1.0
        
        // Controlla quale pulsante è stato premuto
        if node == carButton {
            print("🚗 Car button tapped")
            onCarButtonTapped?() // Trigger closure to transition to LevelScene
        }
        
        if node == quizButton {
            print("quizButton tapped")
            openSwiftUIView()
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        // Se il tocco viene annullato, ripristina l'opacità
        carButton.alpha = 1.0
        quizButton.alpha = 1.0
    }
    
    func openSwiftUIView() {
        if let sceneView = self.view {
            let swiftUIView = QuizView(isInQuizView: .constant(true))
                .environmentObject(ScoreManager())
                .environmentObject(ErrorManager())
                .environmentObject(QuizManager())
            
            let hostingController = UIHostingController(rootView: swiftUIView)
            hostingController.modalPresentationStyle = .fullScreen
            sceneView.window?.rootViewController?.present(hostingController, animated: true)
        }
    }
}
