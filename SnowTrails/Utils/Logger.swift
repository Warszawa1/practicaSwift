//
//  Logger.swift
//  SnowTrails
//
//  Created by Ire  Av on 15/2/25.
//

import Foundation


enum LogLevel {
    case user
    case developer
}


/// Two-level logging system for development and user feedback
class Logger {
    static let shared = Logger()
    private var isDevelopmentMode = true  // true for debugging & false for production
    
    private init() {}
    
    /// Logs a message at the specified level
    /// - Parameters:
    ///   - message: Message to log
    ///   - level: .user for user feedback, .developer for development logs
    func log(_ message: String, level: LogLevel) {
        switch level {
        case .user:
            print(message)
        case .developer:
            if isDevelopmentMode {
                print("🔧 [DEV]: \(message)")
            }
        }
    }
}
