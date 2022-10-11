//
//  NewPollView.swift
//  ranked
//
//  Created by Valentin Silvera on 7/10/22.
//

import SwiftUI

struct NewPollView: View {
    @State var title = ""
    @State var options = ["", ""]
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var viewModel = NewPollViewModel()
    
    var body: some View {
        NavigationView {
            Form{
                Section("Poll title:") {
                    TextField("Write the title of your poll...", text: $title)
                }
                
                Section("Options:") {
                    TextField("Write the first option...", text: $options[0])
                    TextField("Write the second option...", text: $options[1])
                }
                
                if !title.isEmpty && options[0] != "" && options[1] != "" {
                    Button {
                        viewModel.uploadPoll(withTitle: title, withOptions: options)
                    } label: {
                        Text("Create Poll")
                            .font(.headline)
                    }
                } else {
                    Text("Create Poll")
                        .font(.headline)
                        .foregroundColor(.gray)
                }
            }
            .navigationTitle("Create Poll")
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .resizable()
                            .frame(width: 32, height: 32)
                            .foregroundColor(.primary)
                    }
                }
            }
            .onReceive(viewModel.$didUploadPoll) { success in
                if success {
                    dismiss()
                }
            }
        }
    }
}

struct NewPollView_Previews: PreviewProvider {
    static var previews: some View {
        NewPollView()
    }
}

#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif
