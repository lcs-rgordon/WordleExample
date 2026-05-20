//
//  GameState.swift
//  WordleExample
//
//  Created by Russell Gordon on 2026-05-20.
//

import Foundation

/// Describes the current state of a Wordle game session
enum GameState {
    
    /// The game is currently in progress
    case playing
    
    /// The user has successfully guessed the target word
    case won
    
    /// The user has exhausted all guesses without finding the target word
    case lost
}
