import SpriteKit

class LevelScene: SKScene {
    
    var incrocioCroce: SKSpriteNode?
    var bumblebee: SKSpriteNode?
    var car1: SKSpriteNode?
    var go: SKSpriteNode?
    var wait: SKSpriteNode?
    
    var correctSequence: [String] = ["go", "wait"]
    
    override func didMove(to view: SKView) {
        // Verifica e assegna il nodo esistente
        incrocioCroce = childNode(withName: "incrocioCroce") as! SKSpriteNode?
        bumblebee = childNode(withName: "bumblebee") as! SKSpriteNode?
        car1 = childNode(withName: "car1") as! SKSpriteNode?
        go = childNode(withName: "accelerator") as! SKSpriteNode?
        wait = childNode(withName: "brake") as! SKSpriteNode?
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        let node = atPoint(location)

        if node.name == "go" {
            print("go tapped") // Chiamata alla closure per passare a LevelScene
            moveBumblebee()
        }
        
        if node.name == "wait" {
            print("wait tapped")
        }
    }
    
    func moveBumblebee() {
            guard let bumblebee = bumblebee else { return }

            // Movimento verso destra di 300 punti in 2 secondi
            let moveAction = SKAction.moveBy(x: 0, y: 1500, duration: 2.0)
            bumblebee.run(moveAction)
        }
}
