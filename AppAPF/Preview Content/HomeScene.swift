import SpriteKit
import SwiftUI

class HomeScene: SKScene {
    var road = SKSpriteNode()
    var carButton = SKSpriteNode()
    var quizButton = SKSpriteNode()
    var carLights = SKSpriteNode()
    
    var onCarButtonTapped: (() -> Void)?
    var onExitTapped: (() -> Void)?
    
    override func didMove(to view: SKView) {
        road = childNode(withName: "road") as! SKSpriteNode
        carButton = road.childNode(withName: "carButton") as! SKSpriteNode
        quizButton = road.childNode(withName: "quizButton") as! SKSpriteNode
        carLights = road.childNode(withName: "carLights") as! SKSpriteNode
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        let node = atPoint(location)
        
        if node == carButton {
            carButton.alpha = 0.5
        }
        
        if node == quizButton {
            quizButton.alpha = 0.5
        }
        
        if node == carLights {
            carLights.alpha = 0.5
        }
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        let node = atPoint(location)
        
        carButton.alpha = 1.0
        quizButton.alpha = 1.0
        carLights.alpha = 1.0
        
        if node == carButton {
            print("🚗 Car button tapped")
            onCarButtonTapped?()
        }
        
        if node == quizButton {
            print("\nquizButton tapped\n")
            openSwiftUIView()
        }
        
        if node == carLights {
            print("\ncarLights tapped\n")
            openSwiftUIView2()
        }
    }

    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        carButton.alpha = 1.0
        quizButton.alpha = 1.0
    }
    
    func openSwiftUIView() {
        if let sceneView = self.view {
            let swiftUIView = QuizView(isInQuizView: .constant(true))
                .environmentObject(ScoreManager())
                .environmentObject(ErrorManager())
            
            let hostingController = UIHostingController(rootView: swiftUIView)
            hostingController.modalPresentationStyle = .fullScreen
            sceneView.window?.rootViewController?.present(hostingController, animated: true)
        }
    }
    
    func openSwiftUIView2() {
        if let sceneView = self.view {
            let swiftUIView = CarLightsView(isInCarLightsView: .constant(true))
                .environmentObject(ScoreManager())
                .environmentObject(ErrorManager())
            
            let hostingController = UIHostingController(rootView: swiftUIView)
            hostingController.modalPresentationStyle = .fullScreen
            sceneView.window?.rootViewController?.present(hostingController, animated: true)
        }
    }
}
