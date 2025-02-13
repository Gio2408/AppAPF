//
//  PreHomeSceneView.swift
//  AppAPF
//
//  Created by Gioacchino Augello on 13/02/25.
//

import SwiftUI

struct PreHomeSceneView: View {
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea() // Sfondo nero o personalizzabile
            
            VStack {
               
                Text("Benvenuto nel gioco!")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.top, 10)
            }
            .opacity(0.8) // Effetto leggermente trasparente
        }
    }
}

#Preview {
    PreHomeSceneView()
}
