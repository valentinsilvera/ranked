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
    @Environment(\.dismiss) private var dismiss // used for stacked navigation
    
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
                    .foregroundColor(.white)
                
                Text("created by \(viewModel.poll.creator)")
                    .font(.headline)
                    .padding(.horizontal)
                    .foregroundColor(.white)
                
                Spacer()
                
                // here is where we display the results
                TabView {
                    ForEach(0..<3) { i in
                        VStack(alignment: .leading) {
                            AnimatedChart(round: sampleResults.history)
                        }
                        .clipShape(RoundedRectangle(cornerRadius: 10.0, style: .continuous))
                    }
                    .padding()
                }
                .frame(width: UIScreen.main.bounds.width, height: 500)
                .tabViewStyle(PageTabViewStyle())
                
                Text("Burger 🏆")
                    .font(.title)
                    .bold()
                    .foregroundColor(.white)
                    .padding([.top, .horizontal])
                
                Text("with 11 votes")
                    .font(.headline)
                    .padding(.horizontal)
                    .foregroundColor(.white)
                
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
    func AnimatedChart(round: [Round]) -> some View{
        Chart{
            ForEach(round) { result in
                ForEach(result.result.sorted(by: >), id: \.key) { key, value in
                    BarMark(
                        x: .value("count", value),
                        y: .value("item", key)
                    )
                }
            }
        }
        .chartXScale(domain: ClosedRange(uncheckedBounds: (lower: 0, upper: 13)))
        .foregroundColor(.white)
    }
    
}

struct ResultsView_Previews: PreviewProvider {
    static var previews: some View {
        ResultsView(poll: onboardingPoll, votes: [Vote(ballot: ["vote", "vote"])])
    }
}
