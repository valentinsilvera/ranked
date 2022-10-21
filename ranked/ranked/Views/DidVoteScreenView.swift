//
//  DidVoteScreenView.swift
//  ranked
//
//  Created by Valentin Silvera on 20/10/22.
//

import SwiftUI

struct DidVoteScreenView: View {
    @ObservedObject var viewModel: DidVoteScreenViewModel
    @Environment(\.dismiss) private var dismiss
    
    init(poll: Poll) {
        self.viewModel = DidVoteScreenViewModel(poll: poll)
    }
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [.pink, .purple], startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()
            
            VStack(alignment: .leading) {
                Text(viewModel.poll.title)
                    .font(.largeTitle)
                    .padding(.horizontal)
                    .bold()
                
                Text("by \(viewModel.poll.creator)")
                    .padding(.horizontal)
                    .padding(.top, 2)
                
                List{
                    Section(header: Text("Ranked options:")) {
                        if viewModel.ranked.count == 0 {
                            Text("You didn't rank any of the options")
                                .foregroundColor(.gray)
                        } else {
                            ForEach(viewModel.ranked) { vote in
                                Text("vote.")
                            }
                        }
                    }
                    if viewModel.unranked.count > 0 {
                        Section(header: Text("Unranked options:")) {
                            ForEach(viewModel.unranked, id: \.self) { unranked in
                                Text("- \(unranked)")
                            }
                        }
                    }
                }
                .scrollContentBackground(.hidden)
                
                Spacer()
                
                Text("Some disclaimer about the fact that votes can't be modified")
                    .font(.footnote)
                    .padding(.horizontal)
                    .foregroundColor(.white)
                
                Button {
                    dismiss()
                } label: {
                    Text("Go Back")
                        .font(.headline)
                        .foregroundColor(.black)
                        .frame(width: 360, height: 50)
                        .background(Color.white)
                        .clipShape(Capsule())
                        .padding()
                }
            }
        }
        .padding(.top, -40)
    }
}

struct DidVoteScreen_Previews: PreviewProvider {
    static var previews: some View {
        DidVoteScreenView(poll: onboardingPoll)
    }
}
