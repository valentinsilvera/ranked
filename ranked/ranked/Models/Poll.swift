//
//  Poll.swift
//  ranked
//
//  Created by Valentin Silvera on 04.08.22.
//

import Firebase
import FirebaseFirestoreSwift

struct Poll: Identifiable, Decodable {
    /// The Firestore document ID is needed to update / delete the document
    @DocumentID var id: String?
    let uid: String
    let title: String
    let options: [String]
    let votes: [String]
    let timestamp: Timestamp
    let deadline: Date?
    var isClosed: Bool?
    let result: String?

    var votedOn: Bool?
}

let onboardingPoll = Poll(uid: "123", title: "How to use Ranked?", options: [ "Option 1", "Option 2", "Option 3", "Option 4"], votes: [""], timestamp: Timestamp(), deadline: nil, result: nil, votedOn: true)
