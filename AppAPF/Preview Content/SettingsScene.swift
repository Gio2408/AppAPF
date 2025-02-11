//
//  HomeScene.swift
//  AppAPF
//
//  Created by Gioacchino Augello on 08/02/25.
//
import SpriteKit
import SwiftUI

struct SettingsView: View {
    var scene: SKScene {
        let scene = SKScene(fileNamed: "SettingsScene")!
        scene.scaleMode = .aspectFill
        return scene
    }
    
    var body: some View {
        SpriteView(scene: scene)
            .ignoresSafeArea()
    }
}
