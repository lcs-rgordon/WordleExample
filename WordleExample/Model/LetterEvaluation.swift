//
//  LetterEvaluation.swift
//  WordleExample
//
//  Created by Russell Gordon on 2026-05-19.
//

import Foundation

// Describes the current state of a letter in a Wordle guess
enum LetterEvaluation {
    
    // The letter has been typed but the guess has not yet been submitted for evaluation
    case pending
    
    // The letter is not present in the target word
    case notInWord
    
    // The letter is in the target word but in a different position
    case misplaced
    
    // The letter is in the correct position in the target word
    case correct
}
