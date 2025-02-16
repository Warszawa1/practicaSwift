//
//  Validator.swift
//  SnowTrails
//
//  Created by Ire  Av on 15/2/25.
//

import Foundation


enum ValidationError: Error {
    case invalidEmail
    case invalidUsername
    
    var description: String {
        switch self {
        case .invalidEmail:
            return "El email debe tener el formato xxxxx@xxxxx.zz donde zz es .es o .com"
        case .invalidUsername:
            return "El nombre debe tener entre 8 y 24 caracteres alfanuméricos"
        }
    }
}


/// Centralized validation system for user input
class Validator {
    static func validateEmail(_ email: String) -> Bool {
        let emailRegex = "^[a-zA-Z0-9]+@[a-zA-Z0-9]+\\.(es|com)$"
        return email.range(of: emailRegex, options: .regularExpression) != nil
    }
    
    /// Validates username requirements (8-24 alphanumeric characters)
    /// - Parameter username: Username to validate
    /// - Returns: True if username format is valid
    static func validateUsername(_ username: String) -> Bool {
        guard username.count >= 8 && username.count <= 24 else { return false }
        return username.range(of: "^[a-zA-Z0-9]+$", options: .regularExpression) != nil
    }
}
