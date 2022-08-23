//
//  OptionView.swift
//  ranked
//
//  Created by Valentin Silvera on 10.08.22.
//

import SwiftUI

struct OptionView: View {
    @EnvironmentObject private var optionList: OptionList
    var option: Option
    
    var isRanked: Binding<Bool> {
        Binding(
            get: {
                option.isRanked
            },
            set: { isRanked, transaction in
                withTransaction(transaction) {
                    optionList.updateOption(withId: option.id, isRanked: isRanked)
                }
            })
    }
    
    var body: some View {
        Group {
            HStack {
                Text("\(option.name)")
                    .lineLimit(1)
            }
        }
    }
}
