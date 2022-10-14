//
//  User.swift
//  ranked
//
//  Created by Valentin Silvera on 4/10/22.
//

import FirebaseFirestoreSwift

struct FirebaseUser: Identifiable, Decodable {
    @DocumentID var id: String?
    let username: String
}
