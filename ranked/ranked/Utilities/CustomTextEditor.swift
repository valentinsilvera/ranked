//
//  CustomTextEditor.swift
//  ranked
//
//  Created by Valentin Silvera on 11/10/22.
//

import SwiftUI

struct CustomTextEditor: View {
    @Binding var text: String
    let placeholder: String
    
    var body: some View {
        ZStack(alignment: .leading) {
            if text.isEmpty {
                VStack {
                    Text(placeholder)
                        .padding(.top, 10)
                        .padding(.leading, 6)
                    Spacer()
                }
            }
            
            VStack {
                TextEditor(text: $text)
                    .frame(minHeight: 150, maxHeight: 300)
                    .opacity(text.isEmpty ? 0.85 : 1)
                    .lineLimit(1)
                Spacer()
            }
        }
        .padding()
    }
}
