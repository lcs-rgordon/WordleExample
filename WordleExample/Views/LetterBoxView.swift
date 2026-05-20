//
//  LetterBoxView.swift
//  WordleExample
//
//  Created by Russell Gordon on 2026-05-20.
//

import SwiftUI

/// A single square representing one letter in a Wordle guess
struct LetterBoxView: View {
    
    // MARK: - Stored properties
    
    /// The state of the letter, including the character and its evaluation status
    let letter: GuessLetter
    
    // MARK: - Computed properties
    
    var body: some View {
        Text(letter.character)
            .font(.title)
            .fontWeight(.bold)
            // Fixed size for the letter box
            .frame(width: 60, height: 60)
            // Apply background color based on the evaluation (correct, misplaced, etc.)
            .background(backgroundColor)
            .foregroundColor(foregroundColor)
            // Draw a border for pending letters
            .border(borderColor, width: 2)
    }
    
    /// Determines the background color based on the letter's evaluation status
    private var backgroundColor: Color {
        switch letter.status {
        case .pending: return .clear
        case .notInWord: return .gray
        case .misplaced: return .yellow
        case .correct: return .green
        }
    }
    
    /// Determines the text color; white for evaluated letters, primary for pending
    private var foregroundColor: Color {
        switch letter.status {
        case .pending: return .primary
        default: return .white
        }
    }
    
    /// Determines the border color for the box
    private var borderColor: Color {
        switch letter.status {
        case .pending: return .gray.opacity(0.5)
        default: return .clear
        }
    }
}

#Preview {
    HStack {
        LetterBoxView(letter: GuessLetter(character: "A", status: .pending))
        LetterBoxView(letter: GuessLetter(character: "B", status: .correct))
        LetterBoxView(letter: GuessLetter(character: "C", status: .misplaced))
        LetterBoxView(letter: GuessLetter(character: "D", status: .notInWord))
    }
}
