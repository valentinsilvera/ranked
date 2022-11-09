//
//  Vote.swift
//  ranked
//
//  Created by Valentin Silvera on 25/10/22.
//

import Firebase
import FirebaseFirestoreSwift

struct Vote: Identifiable, Codable {
    @DocumentID var id: String? // The Firestore document ID is needed to update / delete the document
    let ballot: [String]
}
