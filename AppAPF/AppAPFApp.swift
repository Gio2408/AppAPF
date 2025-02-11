//
//  AppAPFApp.swift
//  AppAPF
//
//  Created by Gioacchino Augello on 07/02/25.
//

import SwiftUI

@main
struct AppAPFApp: App {
    @StateObject var errorManager = ErrorManager()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(errorManager)
        }
    }
}
