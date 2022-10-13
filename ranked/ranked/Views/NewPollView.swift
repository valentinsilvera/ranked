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
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var viewModel = NewPollViewModel()
    
    var body: some View {
        NavigationView {
            Form{
                Section("Poll title:") {
                    TextField("Write the title of your poll...",
                              text: $title)
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
                    if options.count < 8 {
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
                
                
                
                if !title.isEmpty && options[0] != "" && options[1] != "" {
                    Button {
                        viewModel.uploadPoll(withTitle: title,
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
