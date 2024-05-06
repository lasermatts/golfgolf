//
//  StatsModel.swift
//  golfgolf
//
//  Created by Matt Puchalski on 5/5/24.
//

import Foundation

class StatsModel: ObservableObject {
    static let shared = StatsModel()

    @Published var totalScore: Int = 0
    @Published var holeScores: [Int] = []
    @Published var gameDuration: Double = 0
    @Published var gameDate: Date = Date()

    // Format gameDuration to a human-readable format
    var formattedDuration: String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.unitsStyle = .abbreviated
        return formatter.string(from: TimeInterval(gameDuration)) ?? "0s"
    }

    // Format gameDate to a human-readable format
    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: gameDate)
    }
}

