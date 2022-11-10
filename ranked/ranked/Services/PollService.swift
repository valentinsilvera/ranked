//
//  PollService.swift
//  ranked
//
//  Created by Valentin Silvera on 5/10/22.
//

import Firebase
import UIKit

struct PollService: PollServiceProtocol {
    // uploads a poll with title, creator and options, as well as a completion handler to check wether the poll was successfully uploaded
    func uploadPoll(title: String, creator: String, options: [String], completion: @escaping(Bool) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let data = ["uid": uid,
                    "title": title,
                    "creator": creator,
                    "options": options,
                    "timestamp": Timestamp(date: Date()),
                    "isClosed": false,
                    "results": [""]] as [String : Any]
        
        COLLECTION_POLLS
            .document()
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
    
    // fetches all polls on the database, the completion handler maps them to a collection of polls object
    func fetchPolls(completion: @escaping([Poll]) -> Void) {
        COLLECTION_POLLS
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
    
    // uploads a vote for a poll, with options, the completion handler serves as a way to check wether the vote was successfully uploaded
    func uploadVote(poll: Poll, options: [String], completion: @escaping(Bool) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let pollId = poll.id else { return }
        
        let userVotesRef = COLLECTION_USERS
            .document(uid)
            .collection("voted-polls")
        
        COLLECTION_POLLS
            .document(pollId)
            .collection("votes")
            .document(uid)
            .setData(["ballot":options]) { error in
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
    
    // checks if a poll is on the "voted-polls" collection in the user collection, the completion handler allows us to see wether the poll id is present in said collection
    func checkIfUserVotedOnPoll(_ poll: Poll, completion: @escaping(Bool) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let pollId = poll.id else { return }
        
        COLLECTION_USERS
            .document(uid)
            .collection("voted-polls")
            .document(pollId).getDocument { snapshot, _ in
                guard let snapshot = snapshot else { return }
                completion(snapshot.exists)
            }
    }
    
    // checks if a user id is present in a poll's "votes" collection, as the uid is the key value on the vote document
    func checkForUserVoteOnPoll(_ poll: Poll, completion: @escaping([String]) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let pollId = poll.id else { return }
        
        COLLECTION_POLLS
            .document(pollId)
            .collection("votes")
            .document(uid)
            .getDocument { snapshot, _ in
                guard let document = snapshot?.data() as? [String:Any] else {
                    print("DEBUG: No document for vote")
                    return
                }
                
                if let vote = document["ballot"] as? [String] {
                    completion(vote)
                }
            }
    }
    
    // retrieves all votes for a given poll, the completion handler gives us an array of Votes
    func fetchVotes(_ poll: Poll, completion: @escaping([Vote]) -> Void) {
        guard let pollId = poll.id else { return }
        
        COLLECTION_POLLS
            .document(pollId)
            .collection("votes")
            .getDocuments { snapshot, _ in
                guard let documents = snapshot?.documents else {
                    print("DEBUG: No documents for votes")
                    return
                }
                
                // cast the array of documents as Votes
                let votes = documents.compactMap({ try? $0.data(as: Vote.self)})
                completion(votes)
            }
    }
    
    // updates the value of "isClosed" to closed on a poll, the completion handler lets us check that the poll was closed
    func closePoll(poll: Poll, completion: @escaping(Bool) -> Void) {
        guard let pollId = poll.id else { return }
        
        COLLECTION_POLLS
            .document(pollId)
            .updateData(["isClosed" : true]) { _ in
                completion(true)
            }
    }
}
