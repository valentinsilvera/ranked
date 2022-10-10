//
//  HomeCardView.swift
//  ranked
//
//  Created by Valentin Silvera on 04.08.22.
//

import SwiftUI

struct PollPreviewView: View {
    let poll: Poll
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .fill(LinearGradient(colors: [.pink, .purple], startPoint: .topLeading, endPoint: .bottomTrailing))
                .frame(maxWidth: UIScreen.main.bounds.size.width, minHeight: 100, maxHeight: 120)
            
            HStack {
                VStack(alignment: .leading) {
                    Image(systemName: "star.bubble.fill")
                        .resizable()
                        .frame(width: 32, height: 32)
                    
                    Text(poll.title)
                        .font(.title2)
                    
                    Text("by creator")
                        .font(.callout)
                }
                
                Spacer()
                
                VStack{
                    if poll.votedOn ?? false {
                        Image(systemName: "checkmark.circle.fill")
                            .resizable()
                            .frame(width: 24, height: 24)
                    }
                    
                    HStack {
                        Image(systemName: "person.3.fill")
                        Text("0")
                    }
                }
                
            }
            .padding(12)
            .foregroundColor(.white)
        }
        .padding(12)
    }
}

struct HomeCardView_Previews: PreviewProvider {
    static var previews: some View {
        PollPreviewView(poll: onboardingPoll)
    }
}