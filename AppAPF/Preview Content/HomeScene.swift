import SpriteKit
import SwiftUI

class HomeScene: SKScene {
    var road = SKSpriteNode()
    var carButton = SKSpriteNode()
    var onCarButtonTapped: (() -> Void)? // Closure per comunicare con SwiftUI
    
    var quizButton = SKSpriteNode()
    //var onQuizButtonTapped: (() -> Void)?

    override func didMove(to view: SKView) {
        road = childNode(withName: "road") as! SKSpriteNode
        carButton = road.childNode(withName: "carButton") as! SKSpriteNode
        quizButton = road.childNode(withName: "quizButton") as! SKSpriteNode
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
        
        if node.name == "quizButton" {
            print("quizButton tapped")
            openSwiftUIView()
            //onQuizButtonTapped?() // Chiamata alla closure per passare a QuizView
        }
    }
    
    func openSwiftUIView() {
        if let sceneView = self.view {
            let swiftUIView = QuizView(isInQuizView: .constant(true)).environmentObject(ScoreManager(score: QuizScore(quiz: "Quiz Incroci", totalScore: 8, totalAnswers: 10), currentScore: 0, quizManager: QuizManager()))
                .environmentObject(ErrorManager())
                .environmentObject(QuizManager())
            let hostingController = UIHostingController(rootView: swiftUIView)
            hostingController.modalPresentationStyle = .fullScreen
            sceneView.window?.rootViewController?.present(hostingController, animated: true)
            
        }
    }
}

