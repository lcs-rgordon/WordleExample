//
//  KeyView.swift
//  WordleExample
//
//  Created by Russell Gordon on 2026-05-20.
//

import SwiftUI

/// A single interactive key on the virtual keyboard
struct KeyView: View {
    
    // MARK: - Stored properties
    
    /// The letter displayed on the key
    let letter: String
    
    /// The current evaluation status (correct, misplaced, etc.) to determine color
    let status: LetterEvaluation
    
    /// The closure to execute when the key is clicked
    let action: () -> Void
    
    // MARK: - Computed properties
    
    var body: some View {
        Button(action: action) {
            Text(letter)
                .font(.system(size: 14, weight: .semibold))
                // Key takes up all available space in its frame
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(backgroundColor)
                .foregroundColor(foregroundColor)
                .cornerRadius(4)
        }
        .buttonStyle(.plain)
        // Fixed size for standard letter keys
        .frame(width: 35, height: 45)
    }
    
    /// Background color based on evaluation status
    private var backgroundColor: Color {
        switch status {
        case .pending: return .gray.opacity(0.3)
        case .notInWord: return .gray
        case .misplaced: return .yellow
        case .correct: return .green
        }
    }
    
    /// Text color based on evaluation status
    private var foregroundColor: Color {
        switch status {
        case .pending: return .primary
        default: return .white
        }
    }
}

#Preview {
    HStack {
        KeyView(letter: "A", status: .pending) {}
        KeyView(letter: "B", status: .correct) {}
    }
}
