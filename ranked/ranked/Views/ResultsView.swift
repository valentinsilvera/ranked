//
//  ResultsView.swift
//  ranked
//
//  Created by Valentin Silvera on 25/10/22.
//

import SwiftUI
import Charts

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
                
                AnimatedChart()
                
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
    
    @ViewBuilder
    func AnimatedChart() -> some View{
        Chart{
            ForEach(sampleResults) { item in
                BarMark(
                    x: .value("count", item.count),
                    y: .value("item", item.name)
                )
                .foregroundStyle(by: .value("Shape Color", item.round))
            }
        }
        .onAppear {
            for (index,_) in sampleResults.enumerated() {
                DispatchQueue.main.asyncAfter(deadline: .now() + Double(index) * 0.05) {
                    withAnimation(.interactiveSpring(
                        response: 0.8,
                        dampingFraction: 0.8,
                        blendDuration: 0.8)) {
                            sampleResults[index].animate = true
                        }
                }
            }
        }
    }
    
}

struct ResultsView_Previews: PreviewProvider {
    static var previews: some View {
        ResultsView(poll: onboardingPoll, votes: [Vote(ballot: ["vote", "vote"])])
    }
}
