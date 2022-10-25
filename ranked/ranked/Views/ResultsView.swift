//
//  ResultsView.swift
//  ranked
//
//  Created by Valentin Silvera on 25/10/22.
//

import SwiftUI

struct ResultsView: View {
    @ObservedObject var viewModel: ResultsViewModel
    @Environment(\.dismiss) private var dismiss
    
    init(poll: Poll, votes: [Vote]) {
        self.viewModel = ResultsViewModel(poll: poll, votes: votes)
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
                
                Text("created by \(viewModel.poll.creator)")
                    .font(.headline)
                    .padding(.horizontal)
                
                Spacer()
                
                Button {
                    dismiss()
                } label: {
                    Text("Go Back")
                        .font(.headline)
                        .foregroundColor(.black)
                        .frame(width: 360, height: 50)
                        .background(Color.white)
                        .clipShape(Capsule())
                        .padding(.horizontal)
                        .padding(.vertical, 8)
                }
            }
        }
        .padding(.top, -40)
    }
}

//struct ResultsView_Previews: PreviewProvider {
//    static var previews: some View {
//        ResultsView(poll: onboardingPoll)
//    }
//}
