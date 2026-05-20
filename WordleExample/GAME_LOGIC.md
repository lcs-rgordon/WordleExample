# Wordle Game Logic Trace

This document provides a step-by-step trace of the `WordleViewModel` logic using a sample game.

**Target Word:** `APPLE`

## Guess 1: `BEARS`
*Objective: Identify incorrect letters and misplaced letters.*

| Letter | Evaluation | Reason |
| :--- | :--- | :--- |
| **B** | `notInWord` | Not present in `APPLE`. |
| **E** | `misplaced` | Exists in `APPLE` (index 4) but not at index 1. |
| **A** | `misplaced` | Exists in `APPLE` (index 0) but not at index 2. |
| **R** | `notInWord` | Not present in `APPLE`. |
| **S** | `notInWord` | Not present in `APPLE`. |

**Internal State After Guess 1:**
- `currentGuessIndex`: 1
- `currentLetterIndex`: 0

---

## Guess 2: `PLANT`
*Objective: Handle multiple misplaced letters.*

| Letter | Evaluation | Reason |
| :--- | :--- | :--- |
| **P** | `misplaced` | Exists in `APPLE` (indices 1, 2) but not at index 0. |
| **L** | `misplaced` | Exists in `APPLE` (index 3) but not at index 1. |
| **A** | `misplaced` | Exists in `APPLE` (index 0) but not at index 2. |
| **N** | `notInWord` | Not present in `APPLE`. |
| **T** | `notInWord` | Not present in `APPLE`. |

**Internal State After Guess 2:**
- `currentGuessIndex`: 2
- `currentLetterIndex`: 0

---

## Guess 3: `APPLY`
*Objective: Demonstrate correct positions and the two-pass evaluation logic.*

| Letter | Evaluation | Reason |
| :--- | :--- | :--- |
| **A** | `correct` | Matches `APPLE` at index 0. |
| **P** | `correct` | Matches `APPLE` at index 1. |
| **P** | `correct` | Matches `APPLE` at index 2. |
| **L** | `correct` | Matches `APPLE` at index 3. |
| **Y** | `notInWord` | Not present in `APPLE`. |

**Internal State After Guess 3:**
- `currentGuessIndex`: 3
- `currentLetterIndex`: 0

---

## Guess 4: `APPLE`
*Objective: Full match (Win condition).*

| Letter | Evaluation | Reason |
| :--- | :--- | :--- |
| **A** | `correct` | Matches `APPLE` at index 0. |
| **P** | `correct` | Matches `APPLE` at index 1. |
| **P** | `correct` | Matches `APPLE` at index 2. |
| **L** | `correct` | Matches `APPLE` at index 3. |
| **E** | `correct` | Matches `APPLE` at index 4. |

**Internal State After Guess 4:**
- `currentGuessIndex`: 4
- `currentLetterIndex`: 0
- All letters in the fourth row (index 3) are marked as `.correct`.

---

## Technical Implementation Details

### Two-Pass Evaluation
The `evaluateCurrentGuess()` function uses two passes to ensure accuracy:
1. **Pass One (Correct):** Identifies all letters that are in the exact right spot. These are marked `.correct` and their position in the `targetMatched` array is set to `true`.
2. **Pass Two (Misplaced/Incorrect):** Iterates through the remaining letters. If a letter exists in the target word and its position hasn't been \"claimed\" by a `.correct` match or a previous `.misplaced` match, it is marked `.misplaced`. Otherwise, it is marked `.notInWord`.

This prevents a single letter in the target word from triggering multiple \"yellow\" (misplaced) hints for duplicate letters in the guess.
