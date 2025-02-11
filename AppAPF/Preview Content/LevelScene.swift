//
//  Level.swift
//  AppAPF
//
//  Created by Gioacchino Augello on 10/02/25.
//

import SpriteKit

class LevelScene: SKScene {
    override func didMove(to view: SKView) {
        backgroundColor = .blue  // Colore di sfondo per riconoscere il cambio scena
        
        let label = SKLabelNode(text: "Benvenuto in LevelScene!")
        label.fontSize = 40
        label.fontColor = .white
        label.position = CGPoint(x: size.width / 2, y: size.height / 2)
        addChild(label)
    }
}

