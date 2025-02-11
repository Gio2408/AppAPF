//
//  HomeSceneView+.swift
//  AppAPF
//
//  Created by Gioacchino Augello on 11/02/25.
//

import SwiftUI
import SpriteKit

// SwiftUI View per la HomeScene
struct HomeSceneView: View {
    var scene: SKScene {
        let scene = HomeScene(fileNamed: "HomeScene")!
        scene.scaleMode = .aspectFill
        return scene
    }
    
    var body: some View {
        SpriteView(scene: scene)
            .ignoresSafeArea()
    }
}

#Preview {
    HomeSceneView()
}
