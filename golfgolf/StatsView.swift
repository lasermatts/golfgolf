//
//  StatsView.swift
//  golfgolf
//
//  Created by Matt Puchalski on 5/4/24.
//

import SwiftUI

struct StatsView: View {
    @ObservedObject var statsModel = StatsModel.shared

    var body: some View {
        List {
            Section(header: Text("Game Stats")) {
                Text("Total Score: \(statsModel.totalScore)")
                Text("Game Duration: \(statsModel.formattedDuration)")
                Text("Date: \(statsModel.formattedDate)")
            }
        }
        .navigationTitle("Statistics")
    }
}
