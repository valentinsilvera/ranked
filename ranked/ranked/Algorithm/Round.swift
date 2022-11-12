//
//  Round.swift
//  ranked
//
//  Created by Valentin Silvera on 12/11/22.
//

import Foundation

/// A way to structure the rounds of a vote count
struct Round: Identifiable {
    /// An id so the class conforms to identifiable and can be used with ForEach loops
    var id = UUID()
    
    /// A dictionary where
    /// Key: is the description of the option
    /// Value: is the number of occurences of the option in the current round
    var result: [String : Int]
    
    /// Computed property to get wether the vote with the most count has reached a majority
    /// Returns: true if the threshold has been passed by an option
    var majorityFound: Bool {
        guard let greatestOccurency = (result.max { $0.value < $1.value }) else { return false }
        return greatestOccurency.value >= threshold
    }
    
    /// Computed property to get wether this is the final round
    /// Returns: true if the threshold has been passed by an option, or if there's a tie
    var isFinalRound: Bool {
        if result.count == 2 || majorityFound {
            return true
        } else {
            return false
        }
    }
    
    /// Computed property to get the minimum value to reach majority
    /// Returns: half of the sum of all the ballots in this round, plus one
    private var threshold: Int {
        let sumOccurencies = Array(result.values).reduce(0, +)
        return (sumOccurencies/2) + 1
    }
}
