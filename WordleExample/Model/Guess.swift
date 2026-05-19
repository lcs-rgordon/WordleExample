//
//  Guess.swift
//  WordleExample
//
//  Created by Russell Gordon on 2026-05-19.
//

import Foundation

// Represents a single row (one full word attempt) on the Wordle board
struct Guess: Identifiable {
    
    // MARK: - Stored properties
    
    // Unique identifier to conform to Identifiable protocol
    let id = UUID()
    
    // The collection of letters that make up this specific guess
    var letters: [GuessLetter]
    
    // MARK: - Initializer
    
    // Creates a new guess row with a fixed number of empty letter boxes
    // - wordLength: The number of letters required for the word (e.g., 5)
    init(wordLength: Int) {
        // Create an empty array to hold the letters
        var initialLetters: [GuessLetter] = []
        
        // Fill the array with the specified number of empty letter boxes
        for _ in 0..<wordLength {
            initialLetters.append(GuessLetter())
        }
        
        // Assign the generated letters to the stored property
        self.letters = initialLetters
    }
}
