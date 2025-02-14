import SpriteKit

class LevelScene: SKScene {
    
    var incrocioCroce: SKSpriteNode?
    var bumblebee: SKSpriteNode?
    var car1: SKSpriteNode?
    
    // Sequence of correct actions that need to be followed
    var correctSequence: [String] = ["wait", "go"]
    var indexCorrectSequence: Int = 0
    
    override func didMove(to view: SKView) {
        // Initialize sprite nodes by name
        incrocioCroce = childNode(withName: "incrocioCroce") as? SKSpriteNode
        bumblebee = childNode(withName: "bumblebee") as? SKSpriteNode
        car1 = childNode(withName: "car1") as? SKSpriteNode
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        let node = atPoint(location)
        
        // Reset the sequence if completed
        if indexCorrectSequence >= correctSequence.count {
            print("✅ Sequence completed!")
            indexCorrectSequence = 0
            return
        }

        // Handle Car1 touch
        if node == car1 {
            if correctSequence[indexCorrectSequence] == "wait" {
                print("🚗 Car1 is moving...")
                moveCar1 {
                    self.indexCorrectSequence += 1
                }
            } else {
                print("⛔ It's not Car1's turn yet!")
            }
        }
        
        // Handle Bumblebee touch
        if node == bumblebee {
            if correctSequence[indexCorrectSequence] == "go" {
                print("🚙 Bumblebee is moving...")
                moveBumblebee {
                    self.indexCorrectSequence += 1
                }
            } else {
                print("⛔ It's not Bumblebee's turn yet!")
            }
        }
    }
    
    /// Moves Car1 horizontally
    /// - Parameter completion: Closure to execute after movement
    func moveCar1(completion: @escaping () -> Void) {
        guard let car1 = car1 else { return }
        let moveAction = SKAction.moveBy(x: -1200, y: 0, duration: 2.0)
        car1.run(moveAction, completion: completion)
    }
    
    /// Moves Bumblebee vertically
    /// - Parameter completion: Closure to execute after movement
    func moveBumblebee(completion: @escaping () -> Void) {
        guard let bumblebee = bumblebee else { return }
        let moveAction = SKAction.moveBy(x: 0, y: 1500, duration: 2.0)
        bumblebee.run(moveAction, completion: completion)
    }
}
