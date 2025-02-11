//
//  ErrorManager.swift
//  AppAPF
//
//  Created by Michele Vassallo Todaro on 10/02/25.
//
//Salva gli errori per non farli resettare ogni volta che si riavvia l'app
//Adesso si può usare @StateObject var errorManager = ErrorManager() nelle view


import Foundation

class ErrorManager: ObservableObject {
    @Published var errors: [QuizError] = []
    
    private let key = "savedErrors"

    init() {
        loadErrors()
    }

    // Salva l'errore singolo
    func addError(_ error: QuizError) {
        errors.append(error)
        saveErrors()
    }

    // Salva gli errori in UserDefaults
    private func saveErrors() {
        if let encoded = try? JSONEncoder().encode(errors) {
            UserDefaults.standard.set(encoded, forKey: key)
        }
    }

    // Carica gli errori salvati
    private func loadErrors() {
        if let savedData = UserDefaults.standard.data(forKey: key),
           let decoded = try? JSONDecoder().decode([QuizError].self, from: savedData) {
            errors = decoded
        }
    }
}
