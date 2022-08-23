//
//  OptionListView.swift
//  ranked
//
//  Created by Valentin Silvera on 10.08.22.
//

import SwiftUI

struct OptionListView: View {
    @EnvironmentObject private var optionList: OptionList
    
    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    RankedOptionView()
                    UnrankedOptionView()
                        .onDrop(of: [Option.typeIdentifier], isTargeted: nil) { itemProviders in
                            for itemProvider in itemProviders {
                                itemProvider.loadObject(ofClass: Option.self) { Option, _ in
                                    guard let Option = Option as? Option else { return }
                                    DispatchQueue.main.async {
                                        optionList.updateOption(withId: Option.id, isRanked: true)
                                    }
                                }
                            }
                            return true
                        }
                }
                .navigationBarTitle("Drag Option")
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}
