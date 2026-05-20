//
//  KeyboardView.swift
//  WordleExample
//
//  Created by Russell Gordon on 2026-05-20.
//

import SwiftUI

/// The on-screen keyboard showing letter statuses and allowing mouse interaction
struct KeyboardView: View {
    
    // MARK: - Stored properties
    
    /// The view model containing the game state and alphabet statuses
    var viewModel: WordleViewModel
    
    /// The layout of the QWERTY keyboard
    let rows = [
        ["Q", "W", "E", "R", "T", "Y", "U", "I", "O", "P"],
        ["A", "S", "D", "F", "G", "H", "J", "K", "L"],
        ["Z", "X", "C", "V", "B", "N", "M"]
    ]
    
    // MARK: - Computed properties
    
    var body: some View {
        VStack(spacing: 8) {
            // Draw each row of the keyboard
            ForEach(rows, id: \.self) { row in
                HStack(spacing: 6) {
                    ForEach(row, id: \.self) { letter in
                        // Individual key with its current evaluation status
                        KeyView(letter: letter, status: viewModel.alphabetStatus[letter] ?? .pending) {
                            viewModel.addLetter(letter)
                        }
                    }
                }
            }
            
            // Special keys for submitting and deleting
            HStack(spacing: 6) {
                // Enter key for mouse users
                Button(action: { viewModel.submitGuess() }) {
                    Text("ENTER")
                        .font(.system(size: 12, weight: .bold))
                        .frame(width: 70, height: 45)
                        .background(Color.gray.opacity(0.3))
                        .cornerRadius(4)
                }
                .buttonStyle(.plain)
                
                // Backspace key for mouse users
                Button(action: { viewModel.removeLastLetter() }) {
                    Text("DEL")
                        .font(.system(size: 12, weight: .bold))
                        .frame(width: 50, height: 45)
                        .background(Color.gray.opacity(0.3))
                        .cornerRadius(4)
                }
                .buttonStyle(.plain)
            }
        }
    }
}

#Preview {
    KeyboardView(viewModel: WordleViewModel())
}
