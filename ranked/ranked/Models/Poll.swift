//
//  Poll.swift
//  ranked
//
//  Created by Valentin Silvera on 04.08.22.
//

import Firebase
import FirebaseFirestoreSwift

/// The Poll type, it is identifiable so we can identify it, codable, so we can cast JSON to the type, and equatable so we can compare two or more Poll objects with each other
struct Poll: Identifiable, Codable, Equatable {
    /// The Firestore document ID is needed to update / delete the document
    @DocumentID var id: String?
    /// The user id of the poll creator
    let uid: String
    /// The title or question of the poll
    let title: String
    /// The person who created the poll
    let creator: String
    /// An array of strings describing the options
    let options: [String]
    /// A firebase Timestamp object to be used as the date the poll was created
    let timestamp: Timestamp?
    /// A variable that shows wether a poll is open, so it can be continued to be voted on, or closed, and have the results be counted
    var isClosed: Bool

    /// A variable that's set only locally to check wether the poll has been voted on
    var votedOn: Bool?
}

var onboardingPoll = Poll(uid: "uid", title: "Onboarding Poll", creator: "The Creator", options: ["Option 1", "Option 2"], timestamp: Timestamp(), isClosed: false)
