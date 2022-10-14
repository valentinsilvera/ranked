//
//  VoteScreenViewModel.swift
//  ranked
//
//  Created by Valentin Silvera on 13/10/22.
//

import Foundation

class VoteScreenViewModel: ObservableObject {
    let poll: Poll
    private let service = PollService()
    var noPreferenceList: [String]
    var preferenceList = [String]()
    
    init(poll: Poll, noPreferenceList: [String]) {
        self.poll = poll
        self.noPreferenceList = noPreferenceList
    }
    
    func getUsername() {
        //
    }
    
    func dropNoPreferenceList (at index: Int, _ items: [NSItemProvider]) {
        for item in items {
            _ = item.loadObject(ofClass: String.self) { droppedString, _ in
                if let ss = droppedString {
                    DispatchQueue.main.async {
                        self.noPreferenceList.insert(ss, at: index)
                        self.preferenceList.removeAll { $0 == ss }
                    }
                }
            }
        }
    }
    
    func dropPreferenceList(at index: Int, _ items: [NSItemProvider]) {
        for item in items {
            _ = item.loadObject(ofClass: String.self) { droppedString, _ in
                if let ss = droppedString {
                    DispatchQueue.main.async {
                        self.preferenceList.insert(ss, at: index)
                        self.noPreferenceList.removeAll { $0 == ss }
                    }
                }
            }
        }
    }
    
    func moveNoPreferenceList(from source: IndexSet, to destination: Int) {
        noPreferenceList.move(fromOffsets: source, toOffset: destination)
    }
    
    func movePreferenceList(from source: IndexSet, to destination: Int) {
        preferenceList.move(fromOffsets: source, toOffset: destination)
    }
}
