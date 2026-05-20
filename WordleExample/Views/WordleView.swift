//
//  WordleView.swift
//  WordleExample
//
//  Created by Russell Gordon on 2026-05-20.
//

import SwiftUI

/// The main game interface for Wordle, handling the grid, keyboard, and user input
struct WordleView: View {
    
    // MARK: - Stored properties
    
    /// The view model that manages game state and logic
    @State var viewModel = WordleViewModel()
    
    /// Focus state to ensure the view captures physical keyboard input immediately
    @FocusState private var isFocused: Bool
    
    // MARK: - Computed properties
    
    var body: some View {
        VStack(spacing: 20) {
            // App Title
            Text("WORDLE")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            // The Game Board (Grid of guesses)
            VStack(spacing: 8) {
                ForEach(viewModel.guesses) { guess in
                    GuessRowView(guess: guess)
                }
            }
            .padding()
            
            Spacer()
            
            // The Virtual Keyboard
            KeyboardView(viewModel: viewModel)
                .padding(.bottom)
        }
        .padding()
        // Ensure a comfortable minimum size for the window on macOS
        .frame(minWidth: 500, minHeight: 700)
        // Bind focus state to capture keyboard events
        .focused($isFocused)
        // Handle physical keyboard input
        .onKeyPress { press in
            handleKeyPress(press)
            return .handled
        }
        // Force focus when the view appears
        .onAppear {
            isFocused = true
        }
    }
    
    // MARK: - Functions
    
    /// Processes physical keyboard events
    /// - Parameter press: The KeyPress object containing key information
    private func handleKeyPress(_ press: KeyPress) {
        let characters = press.characters
        
        // Handle specific command keys
        if press.key == .return {
            viewModel.submitGuess()
        } else if press.key == .delete || press.key == .deleteForward || characters == "\u{7F}" || characters == "\u{08}" {
            // Handle backspace and delete keys to remove the last character
            // \u{7F} is the standard ASCII DEL character (Backspace on macOS)
            viewModel.removeLastLetter()
        } else if characters.count == 1 {
            // Handle standard A-Z character input
            let character = characters.uppercased()
            if character >= "A" && character <= "Z" {
                viewModel.addLetter(character)
            }
        }
    }
}

#Preview {
    WordleView()
}
