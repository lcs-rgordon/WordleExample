//
//  WordleViewModel.swift
//  WordleExample
//
//  Created by Russell Gordon on 2026-05-19.
//

import Foundation

// The ViewModel manages the active state of the game and the logic for playing it
@Observable
class WordleViewModel {
    
    // MARK: - Stored properties
    
    // The word the user is trying to guess
    var targetWord: String
    
    // The game board, represented as an array of guesses (rows)
    // Each guess contains an array of letters
    var guesses: [Guess]
    
    // Which row the user is currently typing in (0 to 5)
    var currentGuessIndex: Int
    
    // Which letter box within the current row the user is typing in (0 to 4)
    var currentLetterIndex: Int
    
    // The evaluation status of each letter in the alphabet (for the visual keyboard)
    var alphabetStatus: [String: LetterEvaluation] = [:]
    
    // Constants for game configuration
    let maxGuesses: Int = 6
    let wordLength: Int = 5
    
    // MARK: - Initializer
    
    // Sets up a new game session
    init(targetWord: String = "APPLE") {
        // 1. Set the target word
        self.targetWord = targetWord.uppercased()
        
        // 2. Initialize the board with empty guesses
        var initialGuesses: [Guess] = []
        for _ in 0..<maxGuesses {
            initialGuesses.append(Guess(wordLength: self.wordLength))
        }
        self.guesses = initialGuesses
        
        // 3. Start at the first box of the first row
        self.currentGuessIndex = 0
        self.currentLetterIndex = 0
    }
    
    // MARK: - Functions
    
    // Adds a letter to the current guess if there is space
    func addLetter(_ character: String) {
        // Ensure we haven't filled the current row
        if currentLetterIndex < wordLength {
            // Update the character at the current position
            guesses[currentGuessIndex].letters[currentLetterIndex].character = character.uppercased()
            
            // Move to the next box
            currentLetterIndex += 1
        }
    }
    
    // Removes the last typed letter from the current guess
    func removeLastLetter() {
        // Ensure there is a letter to remove
        if currentLetterIndex > 0 {
            // Move back one box
            currentLetterIndex -= 1
            
            // Clear the character at that position
            guesses[currentGuessIndex].letters[currentLetterIndex].character = ""
        }
    }
    
    // Submits the current row for evaluation
    func submitGuess() {
        // Ensure the row is completely filled
        if currentLetterIndex == wordLength {
            
            // 1. Evaluate each letter against the target word
            evaluateCurrentGuess()
            
            // 2. Move to the next row
            if currentGuessIndex < maxGuesses - 1 {
                currentGuessIndex += 1
                currentLetterIndex = 0
            } else {
                // TODO: Handle game over (win or loss)
                print("Game Over")
            }
        }
    }
    
    // Compares the letters in the current guess to the target word
    private func evaluateCurrentGuess() {
        // Get the current row's letters
        var currentGuessLetters = guesses[currentGuessIndex].letters
        
        // Convert target word to an array of characters for comparison
        let targetChars = Array(targetWord)
        
        // Keep track of which letters in the target word have already been "matched"
        // This prevents double-counting misplaced letters
        var targetMatched = Array(repeating: false, count: targetChars.count)
        
        // FIRST PASS: Find all correct letters (green)
        // We iterate over the indices of the current guess letters array
        for i in currentGuessLetters.indices {
            // Check if indices are valid for both arrays before accessing
            if i < targetChars.count {
                if currentGuessLetters[i].character == String(targetChars[i]) {
                    currentGuessLetters[i].status = .correct
                    targetMatched[i] = true
                }
            }
        }
        
        // SECOND PASS: Find misplaced (yellow) or incorrect (gray) letters
        for i in currentGuessLetters.indices {
            // Skip boxes already marked as correct
            if currentGuessLetters[i].status == .correct { continue }
            
            var foundMisplaced = false
            
            // Check if this letter exists elsewhere in the target word
            // We iterate over the indices of the target characters to find matches
            for j in targetChars.indices {
                if !targetMatched[j] && currentGuessLetters[i].character == String(targetChars[j]) {
                    currentGuessLetters[i].status = .misplaced
                    targetMatched[j] = true
                    foundMisplaced = true
                    break
                }
            }
            
            // If not found elsewhere, it's not in the word
            if !foundMisplaced {
                currentGuessLetters[i].status = .notInWord
            }
        }
        
        // Update the board with the evaluated letters
        guesses[currentGuessIndex].letters = currentGuessLetters
        
        // Update the alphabet status for the visual keyboard
        for letter in currentGuessLetters {
            let char = letter.character
            let status = letter.status
            
            // Only upgrade the status (correct > misplaced > notInWord)
            if let currentStatus = alphabetStatus[char] {
                if status == .correct {
                    alphabetStatus[char] = .correct
                } else if status == .misplaced && currentStatus != .correct {
                    alphabetStatus[char] = .misplaced
                }
            } else {
                alphabetStatus[char] = status
            }
        }
    }
}
