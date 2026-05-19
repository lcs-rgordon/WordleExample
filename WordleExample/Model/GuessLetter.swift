//
//  GuessLetter.swift
//  WordleExample
//
//  Created by Russell Gordon on 2026-05-19.
//

import Foundation

// Represents a single letter box on the Wordle board
struct GuessLetter: Identifiable {
    
    // MARK: - Stored properties
    
    // Unique identifier to conform to Identifiable protocol
    // This allows SwiftUI to uniquely track each letter box
    let id = UUID()
    
    // The actual character typed by the user (e.g., "A", "B", etc.)
    var character: String
    
    // The current evaluation status of this letter
    var status: LetterEvaluation
    
    // MARK: - Initializer
    
    // Creates a new guess letter box
    // - character: The initial character (defaults to an empty string)
    // - status: The initial evaluation status (defaults to .pending)
    init(character: String = "", status: LetterEvaluation = .pending) {
        self.character = character
        self.status = status
    }
}
