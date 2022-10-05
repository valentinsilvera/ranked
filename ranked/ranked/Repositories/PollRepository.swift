//
//  PollRepository.swift
//  ranked
//
//  Created by Valentin Silvera on 5/9/22.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class PollRepository: ObservableObject {    
    let db = Firestore.firestore()
    
    @Published var polls = [Poll]()
    
    func loadData() {
        db.collection("polls").addSnapshotListener { (querySnapshot, error) in
            if let querySnapshot = querySnapshot {
                self.polls = querySnapshot.documents.compactMap { document in
                    try? document.data(as: Poll.self)
                }
            }
        }
    }
}
