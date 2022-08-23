//
//  OptionList.swift
//  ranked
//
//  Created by Valentin Silvera on 10.08.22.
//

import SwiftUI

class OptionList: ObservableObject {
    /// The unique id used for each item created within the list.
    private var nextId: Int = 0
    
    /// The data source of `Option` instances within the list.
    @Published private(set) var items: [Int: Option] = [:]
    
    /// An ordered array of item identifiers that make up the `Option`'s to be shown in the 'Ranked' section.
    @Published private var rankedItemIds: [Int] = []
    
    /// An ordered array of item identifiers that make up the `Option`'s to be shown in the 'Unranked' section.
    @Published private var unrankedItemIds: [Int] = []
    
    /// Returns an ordered array of ranked `Option`s.
    var rankedOptions: [Option] {
        rankedItemIds.compactMap { items[$0] }
    }
    
    /// Returns the total number of ranked `Option`s.
    var rankedCount: Int {
        rankedItemIds.count
    }
    
    /// Returns an ordered array of unranked `Option`s.
    var unrankedOptions: [Option] {
        unrankedItemIds.compactMap { items[$0] }
    }
    
    /// Returns the total number of unranked `Option`s.
    var unrankedCount: Int {
        unrankedItemIds.count
    }
    
    /// Updates the `isRanked` property for a `Option` held within the receiver with the given identifier.
    ///
    /// Toggling the value via this method will also ensure that the Option is moved to the appropriate list of items.
    func updateOption(withId id: Int, isRanked: Bool) {
        guard
            let item = items[id],
            item.isRanked != isRanked
        else { return }
        
        item.isRanked = isRanked
        
        if isRanked {
            rankedItemIds.removeAll { $0 == id }
            unrankedItemIds.append(id)
        } else {
            unrankedItemIds.removeAll { $0 == id }
            rankedItemIds.append(id)
        }
    }
    
    func deleteRankedOptions(atOffsets offsets: IndexSet) {
        for index in offsets {
            items.removeValue(forKey: rankedItemIds[index])
        }
        
        rankedItemIds.remove(atOffsets: offsets)
    }
    
    func moveRankedOptions(fromOffsets source: IndexSet, toOffset destination: Int) {
        rankedItemIds.move(fromOffsets: source, toOffset: destination)
    }
}
