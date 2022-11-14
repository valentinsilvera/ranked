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
    @State var deadline = Date()
    @AppStorage("CREATOR") private var creator = ""
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var viewModel = NewPollViewModel()
    
    var body: some View {
        NavigationView {
            Form{
                Section("Poll title:") {
                    TextField("Write the title of your poll...",
                              text: $title)
                }
                
                Section("Signature:") {
                    TextField("Write your name as a creator of the poll...",
                              text: $creator)
                }
                
                
                Section("Options:") {
                    ForEach(0..<options.count, id: \.self) { index in
                        HStack {
                            TextField("Write option #\(index + 1)...",
                                      text: $options[index])
                            if index != 0 && index != 1 {
                                Spacer()
                                Button {
                                    options.remove(at: index)
                                } label: {
                                    Image(systemName: "minus.circle.fill")
                                        .foregroundColor(.red)
                                        .padding(.horizontal)
                                }
                            }
                        }
                    }
                    if options.count < 8 { // currently setting the max amount of options to 8 per poll
                        Button {
                            withAnimation {
                                options.append("")
                            }
                        } label: {
                            HStack {
                                Text("Add a new option")
                                Spacer()
                                Image(systemName: "plus.circle.fill")
                                    .foregroundColor(.blue)
                                    .padding(.horizontal)
                            }
                        }
                    }
                }                
                
                /// This checks that the poll title is filled, as well as the poll containing at least two options, before presenting the button, otherwise just present a grayed-out text label
                if !title.isEmpty && !creator.isEmpty && options[0] != "" && options[1] != "" {
                    Button {
                        viewModel.uploadPoll(withTitle: title,
                                             by: creator,
                                             withOptions: options)
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
            .previewDevice(PreviewDevice(rawValue: "iPhone 14"))
            .previewDisplayName("iPhone 14")
        
        NewPollView()
            .previewDevice(PreviewDevice(rawValue: "iPhone 14 Pro Max"))
            .previewDisplayName("iPhone 14 Pro Max")
        
        NewPollView()
            .previewDevice(PreviewDevice(rawValue: "iPhone 13 mini"))
            .previewDisplayName("iPhone 13 mini")
        
        NewPollView()
            .previewDevice(PreviewDevice(rawValue: "iPhone SE (3rd generation)"))
            .previewDisplayName("iPhone SE")
    }
}

#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder),
                                        to: nil,
                                        from: nil,
                                        for: nil)
    }
}
#endif
