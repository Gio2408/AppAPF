//
//  LevelSceneView.swift
//  AppAPF
//
//  Created by Gioacchino Augello on 11/02/25.
//

import SwiftUI
import SpriteKit

struct LevelSceneView: View {
    @Binding var isInLevelScene: Bool  // Stato per tornare indietro

    var scene: LevelScene {
        let scene = LevelScene(size: UIScreen.main.bounds.size)
        scene.scaleMode = .aspectFill
        return scene
    }

    var body: some View {
        ZStack {
            SpriteView(scene: scene)
                .ignoresSafeArea()

            VStack {
                HStack {
                    Button(action: {
                        isInLevelScene = false  // Torna alla HomeSceneView
                    }) {
                        Image(systemName: "arrow.left.circle.fill")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .foregroundColor(.white)
                            .background(Circle().fill(Color.black.opacity(0.5)))
                    }
                    .padding()
                    Spacer()
                }
                Spacer()
            }
        }
    }
}
