//
//  HomeScene.swift
//  AppAPF
//
//  Created by Gioacchino Augello on 08/02/25.
//
import SpriteKit

class SettingsScene: SKScene{
    var rectangleBackground = SKSpriteNode()
    override func didMove(to view: SKView) {
        rectangleBackground = SKSpriteNode(imageNamed: "rectangleBackground")
        rectangleBackground.position = CGPoint(x: view.frame.midX, y: view.frame.midY)
        addChild(rectangleBackground)
    }
}
