import SpriteKit

class LevelScene: SKScene {
    
    var incrocioCroce: SKSpriteNode?
    var bumblebee: SKSpriteNode?
    var car1: SKSpriteNode?
    
    var correctSequence: [String] = ["wait", "go"]
    var indexCorrectSequence: Int = 0
    
    override func didMove(to view: SKView) {
        incrocioCroce = childNode(withName: "incrocioCroce") as? SKSpriteNode
        bumblebee = childNode(withName: "bumblebee") as? SKSpriteNode
        car1 = childNode(withName: "car1") as? SKSpriteNode
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        let node = atPoint(location)
        
        // Se la sequenza è completata, resettala
        if indexCorrectSequence >= correctSequence.count {
            print("✅ Sequenza completata!")
            indexCorrectSequence = 0
            return
        }

        if node == car1 {
            if correctSequence[indexCorrectSequence] == "wait" {
                print("🚗 Car1 si muove...")
                moveCar1 {
                    self.indexCorrectSequence += 1
                }
            } else {
                print("⛔ Non è ancora il tuo turno per Car1!")
            }
        }
        
        if node == bumblebee {
            if correctSequence[indexCorrectSequence] == "go" {
                print("🚙 Bumblebee si muove...")
                moveBumblebee {
                    self.indexCorrectSequence += 1
                }
            } else {
                print("⛔ Non è ancora il tuo turno per Bumblebee!")
            }
        }
    }
    
    func moveCar1(completion: @escaping () -> Void) {
        guard let car1 = car1 else { return }
        let moveAction = SKAction.moveBy(x: -1200, y: 0, duration: 2.0)
        car1.run(moveAction, completion: completion)
    }
    
    func moveBumblebee(completion: @escaping () -> Void) {
        guard let bumblebee = bumblebee else { return }
        let moveAction = SKAction.moveBy(x: 0, y: 1500, duration: 2.0)
        bumblebee.run(moveAction, completion: completion)
    }
}
