//  PreHomeSceneView.swift
//  AppAPF
//  Created by Gioacchino Augello on 13/02/25.


import SwiftUI

struct PreHomeSceneView: View {
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            VStack {
                Image("icon")
                    .resizable()
                    .frame(width: 170, height: 170)
                    .cornerRadius(40)
                Text("Way to Go")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
            }
            .opacity(0.8)
        }
    }
}


#Preview {
    PreHomeSceneView()
}
