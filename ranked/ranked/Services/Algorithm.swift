//
//  Algorithm.swift
//  ranked
//
//  Created by Valentin Silvera on 7/11/22.
//

import Foundation

public class VoteCount {
    private var votes: [String]
    private var votesHistory: [[String]] = []
    private var round: Int = 0
    private var filledVotes: Int = 0
    private var emptyVotes: Int = 0
    private var totalVotes: Int = 0
    private var done: Bool = false
    private var majorityFound: Bool = false
    private var winner = String()
    
    public init(votes: [String]) {
        self.votes = votes
        votesHistory.append(votes)
    }
    
    func count() {
        var firstChoice = [String]()
        var loser = String()
        
        while !done {
            
            for vote in votes {
                firstChoice.append(vote)
            }
            
            if let lastOption = findLoser(for: firstChoice) {
                loser = lastOption
            }
            
            round += 1
            removeOption(from: votes, remove: loser)
            winnerFound(for: firstChoice)
            
            print(winner)
        }
        
        print(votes)
    }
    
    private func findLoser(for votes: [String]) -> String? {
        var numberOfVotes = votes.count
        
        let scores = votes.histogram
        
        let wrappedMaxScore = scores.min { a, b in a.value < b.value}
        
        var loser = String()
        
        if let (key, value) = wrappedMaxScore {
            return key
        } else {
            return nil
        }
    }
    
    func removeOption(from votes: [String], remove option: String) {
        for vote in votes {
            //            self.votes["\(vote)"] = votes.filter(){$0 != option}
        }
    }
    
    private func winnerFound (for votes: [String]) -> Bool {
        var numberOfVotes = votes.count
        
        let scores = votes.histogram
        
        let wrappedMaxScore = scores.max { a, b in a.value < b.value}
        
        var leader = String()
        var score = Int()
        
        if let (key, value) = wrappedMaxScore {
            leader = key
            score = value
        }
        
        //TODO: this check is a mess and a half
        
        if score > numberOfVotes/2 {
            winner = leader
            majorityFound = true
            done = true
            return true
        } else  if score == numberOfVotes/2 {
            done = true
            winner = leader
            return true
        } else {
            return false
        }
    }
}

extension Sequence where Element: Hashable {
    var histogram: [Element: Int] {
        return self.reduce(into: [:]) {counts, elem in counts[elem, default: 0] += 1}
    }
}

struct Result: Identifiable {
    var id = UUID()
    var name: String
    var count: Double
    var animate: Bool = false
}

struct Round: Identifiable {
    var id = UUID()
//    var roundNumber: Int
    var results: [Result]
}

//var sampleResults: [Round] = [
//    Round(
////        roundNumber: 1,
//        results:
//            [Result(name: "Pizza", count: 8),
//             Result(name: "Burger", count: 6),
//             Result(name: "Pasta", count: 6),
//             Result(name: "Sushi", count: 3)]
//    ),
//    Round(
////        roundNumber: 2,
//        results:
//            [Result(name: "Pizza", count: 8),
//             Result(name: "Burger", count: 8),
//             Result(name: "Pasta", count: 7)]
//    ),
//    Round(
////        roundNumber: 3,
//        results:
//            [Result(name: "Pizza", count: 9),
//             Result(name: "Burger", count: 11)]
//    )
//]

var sampleResultsRound1: [Result] = [Result(name: "Pizza", count: 8), Result(name: "Burger", count: 6), Result(name: "Pasta", count: 6), Result(name: "Sushi", count: 3)]

var sampleResultsRound2: [Result] = [Result(name: "Pizza", count: 8), Result(name: "Burger", count: 9), Result(name: "Pasta", count: 6), Result(name: "Sushi", count: 0)]

var sampleResultsRound3: [Result] = [Result(name: "Pizza", count: 10), Result(name: "Burger", count: 11), Result(name: "Pasta", count: 0), Result(name: "Sushi", count: 0)]
