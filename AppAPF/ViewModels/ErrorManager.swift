import Foundation

class ErrorManager: ObservableObject {
    @Published var errors: [QuizError] = []
    @Published var lightErrors: [QuizError] = []
    
    private let key = "savedErrors"
    private let warningKey = "savedWarningErrors"

    init() {
        loadErrors()
    }

    // Adds a new error to the list and saves it persistently.
    func addError(_ error: QuizError) {
        errors.append(error)
        saveErrors()
    }
    
    // Adds a new error to the list and saves it persistently.
    func addWarningError(_ warningError: QuizError) {
        lightErrors.append(warningError)
        saveWarningErrors()
    }

    // Saves the current list of errors to UserDefaults.
    func saveErrors() {
        if let encoded = try? JSONEncoder().encode(errors) {
            UserDefaults.standard.set(encoded, forKey: key)
        }
    }
    
    func saveWarningErrors() {
        if let encoded = try? JSONEncoder().encode(lightErrors) {
            UserDefaults.standard.set(encoded, forKey: warningKey)
        }
    }

    // Loads previously saved errors from UserDefaults.
    func loadErrors() {
        if let savedData = UserDefaults.standard.data(forKey: key),
           let decoded = try? JSONDecoder().decode([QuizError].self, from: savedData) {
            errors = decoded
        }
    }
    
    func loadWarningErrors() {
        if let savedData2 = UserDefaults.standard.data(forKey: warningKey),
           let decoded2 = try? JSONDecoder().decode([QuizError].self, from: savedData2) {
            lightErrors = decoded2
        }
    }
    
    func deleteErrors() {
        errors.removeAll()
        saveErrors()
    }
    
    func deleteWarningErrors() {
        lightErrors.removeAll()
        saveWarningErrors()
    }
}
