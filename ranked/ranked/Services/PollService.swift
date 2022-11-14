//
//  PollService.swift
//  ranked
//
//  Created by Valentin Silvera on 5/10/22.
//

import Firebase
import UIKit

/// Centralized service for all API calls in the app
struct PollService: PollServiceProtocol {
    
    /**
     Uploads a poll with title, creator and options, as well as a completion handler to check wether the poll was successfully uploaded
     
     - Parameters:
     - title: The title or question of the poll
     - creator: The name of the person that created the poll
     - options: An array of options for the poll
     
     - Returns: True if the poll was correctly uploaded via completion handler
     */
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
    
    /**
     Fetches all polls on the database, the completion handler maps them to a collection of polls object
     
     - Returns: An array with all the polls currently on the database
     */
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
    
    /**
     Uploads a vote for a poll, with options, the completion handler serves as a way to check wether the vote was successfully uploaded
     
     - Parameters:
     - poll: The poll we want to submit the vote to
     - options: An array of strings with the ranked/unranked options from the voter
     
     - Returns: True if the vote was correctly uploaded via completion handler
     */
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
    
    /**
     Checks if a poll is on the "voted-polls" collection in the user collection
     
     - Parameters:
     - poll: The poll we want to check if the user has voted on
     
     - Returns: True if the poll is in the user's voted-polls collection
     */
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
    
    /**
     Checks if a user id is present in a poll's "votes" collection, as the uid is the key value on the vote document
     
     - Parameters:
     - poll: The poll we want the votes for
     
     - Returns: An array of votes as strings
     */
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
    
    /**
     Retrieves all votes for a given poll
     
     - Parameters:
     - poll: The poll we want all the votes for
     
     - Returns: A collection of Votes for the poll
     */
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
    
    /**
     Updates the value of "isClosed" to closed on a poll
     
     - Parameters:
     - poll: The poll we want to close
     
     - Returns: True if the poll was correctly closed via completion handler
     */
    func closePoll(poll: Poll, completion: @escaping(Bool) -> Void) {
        guard let pollId = poll.id else { return }
        
        COLLECTION_POLLS
            .document(pollId)
            .updateData(["isClosed" : true]) { _ in
                completion(true)
            }
    }
}
