//
//  Algorithm.swift
//  ranked
//
//  Created by Valentin Silvera on 7/11/22.
//

import Foundation

/// A class to count all the votes for a single poll (poll object not needed)
class Count {
    /// A collection of votes to be counted
    let votes: [Vote]
    
    /// A collection that stores the results for each round of counting
    var history = [Round]()
    
    /// Stores wether there was a majority found
    var majorityFound = false
    
    /// Computed Property that gets the ballots from each vote
    var ballots: [[String]] {
        var currentBallots = [[String]]()
        for vote in votes {
            currentBallots.append(vote.ballot)
        }
        return currentBallots
    }
    
    /// Computed property that gets the option with the most occurences to return as a winner, key is the option and the value are the occurances of said option
    var winner: [String:Int] {
        guard let highestResult = (history[0].result.max { $0.value < $1.value }) else { return ["":0] }
        return [highestResult.key:highestResult.value]
    }
    
    /**
     Initializes a vote count.
     
     - Parameters:
     - votes: The votes to be counted
     
     - Returns: An array with the rounds of results of the vote count
     */
    init(votes: [Vote]) {
        self.votes = votes
        getRounds()
    }
    
    
    /// Loops through all the rounds to create a history of votes on each round
    func getRounds() {
        /// An internal check to know when to stop the loop
        var isFinalRound = false
        /// Store the current ballots which will be counted in this loop
        var currentBallots = ballots
        
        while !isFinalRound {
            /// Calculate and store the results for this round
            let round = getRoundResults(ballots: currentBallots)
            /// Count ballots if a majority has not yet been found
            if !round.isFinalRound {
                /// Make sure that there are results inside the round, otherwise escape the function
                guard let minimumOccurency = (round.result.min { $0.value < $1.value }) else { return }
                /// A variable to assign the ballots withouth the least-voted option
                var newBallots = [[String]]()
                /// Loop through the current ballot, filter out the option with the least votes, and assign it to the newBallot
                for ballot in currentBallots {
                    let newBallot = ballot.filter { $0 != minimumOccurency.key }
                    newBallots.append(newBallot)
                }
                /// Replace the current ballots with the new ones
                currentBallots = newBallots
            } else {
                /// If the majority has been found, change the class' majority found value to true
                if round.majorityFound {
                    self.majorityFound = true
                }
                /// If the round checks that it was the final round, assign it to the function's boolean of final round
                isFinalRound = true
            }
        }
    }
    
    /**
     Class-private function that computes the results for a single round
     
     - Parameters:
     - ballots: The votes to be counted on this round
     
     - Returns: A Round object
     */
    private func getRoundResults(ballots: [[String]]) -> Round {
        /// Stores the result of this round
        var result = [String : Int]()
        /// Loops through each ballot's first option
        for ballot in ballots {
            /// Stores the first option of the ballot
            guard let firstRanked = ballot[safe: 0] else { continue }
            /// Checks if the option exists in the dictionary
            /// - If it doesn't, add it with a count of 1
            /// - If it does, increment the count of that option by one
            if result.index(forKey: firstRanked) == nil {
                result[firstRanked] = 1
            } else {
                guard let occurencies = result[firstRanked] else { break }
                result.updateValue(occurencies + 1, forKey: firstRanked)
            }
        }
        /// Stores the result of the round count
        let round = Round(result: result)
        /// Appends this round to the class' collection of rounds
        history.append(round)
        return round
    }
}

/// Extend collections that use index (ie Arrays) to return nil if the index is empty, instead of the error index out of range
/// Code snippet from https://wendyliga.medium.com/say-goodbye-to-index-out-of-range-swift-eca7c4c7b6ca
extension Collection where Indices.Iterator.Element == Index {
    public subscript(safe index: Index) -> Iterator.Element? {
        return (startIndex <= index && index < endIndex) ? self[index] : nil
    }
}

let sampleVotes = [
    Vote(ballot: ["pizza", "burger", "sushi", "ramen"]),
    Vote(ballot: ["ramen", "sushi",]),
    Vote(ballot: ["ramen", "pizza",]),
    Vote(ballot: ["burger", "pizza", "ramen"]),
    Vote(ballot: ["sushi", "burger"]),
    Vote(ballot: ["burger", "sushi"]),
    Vote(ballot: ["burger", "sushi"]),
    Vote(ballot: ["pizza", "burger", "sushi"]),
    Vote(ballot: ["pizza", "burger", "sushi"])
]

let sampleResults = Count(votes: sampleVotes)
