//
//  ErrorManager.swift
//  AppAPF
//
//  Created by Michele Vassallo Todaro on 10/02/25.
//
// Manages quiz errors persistently to retain data across app restarts.

import Foundation

class ErrorManager: ObservableObject {
    @Published var errors: [QuizError] = []
    
    private let key = "savedErrors"

    init() {
        loadErrors()
    }

    /// Adds a new error to the list and saves it persistently.
    func addError(_ error: QuizError) {
        errors.append(error)
        saveErrors()
    }

    /// Saves the current list of errors to UserDefaults.
    private func saveErrors() {
        if let encoded = try? JSONEncoder().encode(errors) {
            UserDefaults.standard.set(encoded, forKey: key)
        }
    }

    /// Loads previously saved errors from UserDefaults.
    private func loadErrors() {
        if let savedData = UserDefaults.standard.data(forKey: key),
           let decoded = try? JSONDecoder().decode([QuizError].self, from: savedData) {
            errors = decoded
        }
    }
}
