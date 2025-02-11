import SpriteKit

class LevelScene: SKScene {
    
    var incrocioCroce: SKSpriteNode?
    var bumblebee: SKSpriteNode?
    var car1: SKSpriteNode?
    var accelerator: SKSpriteNode?
    var brake: SKSpriteNode?
    
    override func didMove(to view: SKView) {
        // Verifica e assegna il nodo esistente
        incrocioCroce = childNode(withName: "incrocioCroce") as! SKSpriteNode?
        bumblebee = childNode(withName: "bumblebee") as! SKSpriteNode?
        car1 = childNode(withName: "car1") as! SKSpriteNode?
        accelerator = childNode(withName: "accelerator") as! SKSpriteNode?
        brake = childNode(withName: "brake") as! SKSpriteNode?
    }
}
