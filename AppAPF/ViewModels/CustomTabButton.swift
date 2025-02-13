//
//  CustomButton.swift
//  AppAPF
//
//  Created by Gioacchino Augello on 11/02/25.
//

import SwiftUI

struct CustomTabButton: View {
    let icon: String
    let tag: Int
    @Binding var selectedTab: Int

    var body: some View {
        Button(action: {
            selectedTab = tag
        }) {
            Image(systemName: icon)
                .resizable()
                .frame(width: 30, height: 30)
                .padding()
                .foregroundColor(selectedTab == tag ? .blue : .gray)
        }
    }
}
