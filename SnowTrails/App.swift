//
//  App.swift
//  SnowTrails
//
//  Created by Ire  Av on 15/2/25.
//

import Foundation

/// Main application controller that serves as the entry point for the SnowTrails application.
/// Handles the initialization and startup of the application.
final class App {
    private let mainMenu: MainMenu
    
    /// Initializes the application and sets up the main menu
    init() {
        self.mainMenu = MainMenu()
    }
    
    /// Starts the application and shows the main menu to the user
    func run() {
        print("Starting SnowTrails application...")
        mainMenu.showMainMenu()
    }
}
