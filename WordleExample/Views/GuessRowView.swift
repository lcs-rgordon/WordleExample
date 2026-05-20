//
//  GuessRowView.swift
//  WordleExample
//
//  Created by Russell Gordon on 2026-05-20.
//

import SwiftUI

/// Represents a single row of letters in the Wordle grid
struct GuessRowView: View {
    
    // MARK: - Stored properties
    
    /// The guess data for this specific row
    let guess: Guess
    
    // MARK: - Computed properties
    
    var body: some View {
        HStack(spacing: 8) {
            // Iterate through each letter in the guess and display its box
            ForEach(guess.letters) { letter in
                LetterBoxView(letter: letter)
            }
        }
    }
}

#Preview {
    GuessRowView(guess: Guess(wordLength: 5))
}
