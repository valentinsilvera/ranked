//
//  DroppableList.swift
//  ranked
//
//  Created by Valentin Silvera on 18/10/22.
//

import SwiftUI

struct DroppableList: View {
    let title: String
    @Binding var options: [String]
    
    //this action is performed when a drop is made
    //parameters are:
    //  the dropped String
    //  the index where it was dropped
    //it's Optional in case we don't need to do anything else
    let action: ((String, Int) -> Void)?
    
    init(_ title: String, options: Binding<[String]>, action: ((String, Int) -> Void)? = nil) {
        self.title = title
        self._options = options //assign to the Binding, nont the WrappedValue
        self.action = action
    }
    
    var body: some View {
        List {
            Text(title)
                .font(.subheadline)
                .onDrop(of: [.plainText], isTargeted: nil, perform: dropOnEmptyList)
            if options.count == 0 && title == "Preference" {
                Text("Drag options here to set your preferences...")
                    .foregroundColor(.gray)
                    .onDrop(of: [.plainText], isTargeted: nil, perform: dropOnEmptyList)
            } else if options.count == 0 && title == "No Preference" {
                Text("Drag options here to remove them from your preferences...")
                    .foregroundColor(.gray)
                    .onDrop(of: [.plainText], isTargeted: nil, perform: dropOnEmptyList)
            } else {
                ForEach(options, id: \.self) { option in
                    Text(option)
                        .onDrag { NSItemProvider(object: option as NSString) }
                }
                .onMove(perform: moveOption)
                .onInsert(of: [.plainText], perform: dropOption)
            }
        }
//        .scrollContentBackground(.hidden)
    }
    
    func moveOption(from source: IndexSet, to destination: Int) {
        options.move(fromOffsets: source, toOffset: destination)
    }
    
    func dropOption(at index: Int, _ items: [NSItemProvider]) {
        for item in items {
            _ = item.loadObject(ofClass: String.self) { droppedString, _ in
                if let ss = droppedString, let dropAction = action {
                    DispatchQueue.main.async {
                        dropAction(ss, index)
                    }
                }
            }
        }
    }
    
    func dropOnEmptyList(items: [NSItemProvider]) -> Bool {
        dropOption(at: options.endIndex, items)
        return true
    }
}
