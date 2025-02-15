//  PreHomeSceneView.swift
//  AppAPF
//  Created by Gioacchino Augello on 13/02/25.


import SwiftUI

struct PreHomeSceneView: View {
    var body: some View {
        ZStack {
            // Black background covering the entire screen
            Color.black.ignoresSafeArea()

            VStack {
                // App icon displayed with size and rounded corners
                Image("icon")
                    .resizable()
                    .frame(width: 170, height: 170)
                    .cornerRadius(40)

                // Title text displayed in large, bold, white font
                Text("Way to Go")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
            }
            .opacity(0.8)  // Slight transparency effect for the content
        }
    }
}


#Preview {
    PreHomeSceneView()
}
