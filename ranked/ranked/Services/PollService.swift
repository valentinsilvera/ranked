//
//  PollService.swift
//  ranked
//
//  Created by Valentin Silvera on 5/10/22.
//

import Firebase
import UIKit

struct PollService {
    func uploadPoll(title: String, creator: String, options: [String], completion: @escaping(Bool) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let data = ["uid": uid,
                    "title": title,
                    "creator": creator,
                    "options": options,
                    "timestamp": Timestamp(date: Date()),
                    "isClosed": false,
                    "results": [""]] as [String : Any]
        
        Firestore.firestore().collection("polls").document()
            .setData(data) { error in
                if let error {
                    print("DEBUG: Failed with error: \(error.localizedDescription)")
                    completion(false)
                    return
                } else {
                    completion(true)
                }
            }
    }
    
    func fetchPolls(completion: @escaping([Poll]) -> Void) {
        Firestore.firestore().collection("polls")
            .order(by: "timestamp", descending: true)
            .getDocuments { snapshot, _ in
                guard let documents = snapshot?.documents else {
                    print("DEBUG: No documents for polls")
                    return
                }
                
                let polls = documents.compactMap({ try? $0.data(as: Poll.self)})
                completion(polls)
            }
    }
    
    func uploadVote(poll: Poll, options: [String], completion: @escaping(Bool) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let pollId = poll.id else { return }

        let userVotesRef = Firestore.firestore()
            .collection("users")
            .document(uid)
            .collection("voted-polls")

        Firestore.firestore()
            .collection("polls")
            .document(pollId)
            .collection("votes")
            .document(uid)
            .setData([uid:options]) { error in
                if let error {
                    print("DEBUG: Failed to upload vote with error \(error)")
                    completion(false)
                    return
                } else {
                    userVotesRef.document(pollId).setData([:])
                    completion(true)
                }

            }
    }
    
    func checkIfUserVotedOnPoll(_ poll: Poll, completion: @escaping(Bool) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let pollId = poll.id else { return }

        Firestore.firestore()
            .collection("users")
            .document(uid)
            .collection("voted-polls")
            .document(pollId).getDocument { snapshot, _ in
                guard let snapshot = snapshot else { return }
                completion(snapshot.exists)
            }
    }
    
    func checkForUserVoteOnPoll(_ poll: Poll, completion: @escaping([String]) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let pollId = poll.id else { return }
        
        Firestore.firestore()
            .collection("polls")
            .document(pollId)
            .collection("votes")
            .document(uid)
            .getDocument { snapshot, _ in
                guard let document = snapshot?.data() as? [String:Any] else {
                    print("DEBUG: No document for vote")
                    return
                }
                
                if let vote = document[uid] as? [String] {
                    print("DEBUG: vote is \(vote)")
                    completion(vote)
                }
            }
    }
    
//    func checkIfUserCreatedPoll(_ poll: Poll, completion: @escaping(Bool) -> Void) {
//        guard let uid = Auth.auth().currentUser?.uid else { return }
//        guard let pollId = poll.id else { return }
//
//        Firestore.firestore()
//            .collection("users")
//            .document(uid).collection("created-polls")
//            .document(chirpId).getDocument { snapshot, _ in
//                guard let snapshot = snapshot else { return }
//                completion(snapshot.exists)
//            }
//    }
}
