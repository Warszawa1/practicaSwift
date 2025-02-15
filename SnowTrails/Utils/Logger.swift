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

class Logger {
    static let shared = Logger()
    private var isDevelopmentMode = true  // true for debugging & false for production
    
    private init() {}
    
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
