//
//  Poll.swift
//  ranked
//
//  Created by Valentin Silvera on 04.08.22.
//

import Firebase
import FirebaseFirestoreSwift

struct Poll: Identifiable, Codable {
    /// The Firestore document ID is needed to update / delete the document
    @DocumentID var id: String?
    let uid: String
    let title: String
    let creator: String
    let options: [String]
    let timestamp: Timestamp
    let deadline: Date?
    var isClosed: Bool
    let result: String?

    var votedOn: Bool?
}

let onboardingPoll = Poll(uid: "uid", title: "Onboarding Poll", creator: "The Creator", options: ["Option 1", "Option 2"], timestamp: Timestamp(), deadline: nil, isClosed: false, result: nil)
