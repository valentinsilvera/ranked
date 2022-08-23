//
//  UnrankedOptionView.swift
//  ranked
//
//  Created by Valentin Silvera on 10.08.22.
//

import SwiftUI

struct UnrankedOptionView: View {
    @EnvironmentObject private var optionList: OptionList
    @Environment(\.isEnabled) private var isRanked: Bool
    
    var body: some View {
        Group {
            Text("Completed")
            
            ForEach(optionList.unrankedOptions) { option in
                OptionView(option: option)
            }
        }
        .opacity(isRanked ? 1.0 : 0.2)
    }
}
