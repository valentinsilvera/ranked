//
//  RankedOptionView.swift
//  ranked
//
//  Created by Valentin Silvera on 10.08.22.
//

import SwiftUI

struct RankedOptionView: View {
    @EnvironmentObject private var optionList: OptionList
    
    var body: some View {
        Text("Ranked")
        
        ForEach(optionList.rankedOptions) { option in
            OptionView(option: option)
                .onDrag {
                    NSItemProvider(object: option)
                }
            Text("placeholder")
        }
        .onMove(perform: optionList.moveRankedOptions(fromOffsets:toOffset:))
    }
}
