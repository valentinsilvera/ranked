//
//  OptionDropDelegate.swift
//  ranked
//
//  Created by Valentin Silvera on 10.08.22.
//

import SwiftUI

struct TodoDropDelegate: DropDelegate {
    @Binding var focusId: Int?
    
    func performDrop(info: DropInfo) -> Bool {
        guard info.hasItemsConforming(to: [Option.typeIdentifier]) else {
            return false
        }
        
        let itemProviders = info.itemProviders(for: [Option.typeIdentifier])
        guard let itemProvider = itemProviders.first else {
            return false
        }
        
        itemProvider.loadObject(ofClass: Option.self) { Option, _ in
            let Option = Option as? Option
            
            DispatchQueue.main.async {
                self.focusId = Option?.id
            }
        }
        
        return true
    }
}
