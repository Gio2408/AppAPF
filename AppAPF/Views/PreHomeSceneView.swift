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
               
                Image("icon")
                    .resizable()
                    .frame(width: 150, height: 150)
                    .cornerRadius(55)
                Text("Way to Go")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
            }
            .opacity(0.8) // Effetto leggermente trasparente
        }
    }
}

#Preview {
    PreHomeSceneView()
}
