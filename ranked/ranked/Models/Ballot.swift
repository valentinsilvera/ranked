//
//  Vote.swift
//  ranked
//
//  Created by Valentin Silvera on 04.08.22.
//

import Foundation

struct Ballot {
    let title: String
    let options: [String]
    let votes: [String]
    let creator: String
    let dateCreated = Date()
    let deadline: Date?
    var isClosed: Bool = false
    var votedOn: Bool = false
    let result: String?
}

let onboardingBallot = Ballot(title: "How to use Ranked?", options: ["Option 1", "Option 2", "Option 3", "Option 4"], votes: [""], creator: "The creator", deadline: nil, votedOn: true, result: nil)

let testOpenBallot = Ballot(title: "What's the best language?", options: ["Swift", "JS", "Python", "C", "Rust"], votes: [""], creator: "Valentin", deadline: Date(timeIntervalSinceReferenceDate: 681500000), result: nil)

let testClosedBallot = Ballot(title: "Lunch plans for Barcelona", options: ["Pizza", "Tacos", "Tapas", "Sushi", "Pasta"], votes: [""], creator: "Marc", deadline: Date(timeIntervalSinceReferenceDate: 681250000), isClosed: true, result: "Tapas")
