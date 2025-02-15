//
//  AppAPFApp.swift
//  AppAPF
//
//  Created by Gioacchino Augello on 07/02/25.
//

import SwiftUI

@main
// Main entry point for the application
struct AppAPFApp: App {
    
    // StateObject is used to create and manage the lifecycle of errorManager
    @StateObject var errorManager = ErrorManager()

    var body: some Scene {
        WindowGroup {
            // ContentView is set as the initial view of the app
            ContentView()
                // Injects errorManager into the environment, making it accessible to all views
                .environmentObject(errorManager)
        }
    }
}
