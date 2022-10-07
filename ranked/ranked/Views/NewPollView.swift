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
        VStack{
            HStack {
                Spacer()
                
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .resizable()
                        .frame(width: 32, height: 32)
                        .foregroundColor(.primary)
                }
            }
            .padding()
            
            Group {
                TextEditor(text: $title)
                TextEditor(text: $options[0])
                TextEditor(text: $options[1])
            }
            .border(.white)
            
            
            Button {
                viewModel.uploadPoll(withTitle: title, withOptions: options)
            } label: {
                Text("Create Poll")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(width: 340, height: 50)
                    .background(Color(.systemBlue))
                    .clipShape(Capsule())
                    .padding()
            }
        }
        .onReceive(viewModel.$didUploadPoll) { success in
            if success {
                dismiss()
            }
        }
    }
}

struct NewPollView_Previews: PreviewProvider {
    static var previews: some View {
        NewPollView()
    }
}
