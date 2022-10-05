//
//  Vote.swift
//  ranked
//
//  Created by Valentin Silvera on 04.08.22.
//

import Firebase
import FirebaseFirestoreSwift

struct Poll: Codable, Identifiable{
    /// The Firestore document ID is needed to update / delete the document
    @DocumentID var docId: String?
    var id: String = UUID().uuidString
    let title: String
    let options: [String]
    let votes: [String]
    let creator: String
    let creatorID: String
    var votersID: [String]?
    let timestamp: Timestamp
    let deadline: Date? 
    var isClosed: Bool?
    let result: String?
    
    var votedOn: Bool?
}

let onboardingPoll = Poll(title: "How to use Ranked?", options: [ "Option 1", "Option 2", "Option 3", "Option 4"], votes: [""], creator: "The creator", creatorID: "1a2b3c", timestamp: Timestamp(), deadline: nil, result: nil, votedOn: true)
