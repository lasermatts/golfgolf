//
//  HoleView.swift
//  golfgolf
//
//  Created by Matt Puchalski on 4/29/24.
//

import SwiftUI

struct HoleView: View {
    @Binding var gameType: String
    @Binding var numberOfHoles: Int
    @Binding var parType: String
    
    @State private var currentHoleNumber = 1
    @State private var strokes = 0
    @State private var globalScore = 0
    @State private var holeScores: [Int] = Array(repeating: 0, count: 18) // Assume a max of 18 holes

    var body: some View {
        VStack {
            Text("Hole \(currentHoleNumber)")
                .font(.largeTitle)
                .padding()

            Text("Strokes: \(holeScores[currentHoleNumber - 1])") // Current hole score
                .font(.title)
                .padding()

            Text("Global Score: \(globalScore)") // Global score
                .font(.title)
                .padding()

            HStack {
                Button(action: {
                    if holeScores[currentHoleNumber - 1] > 0 {
                        holeScores[currentHoleNumber - 1] -= 1
                        globalScore -= 1
                    }
                }) {
                    Image(systemName: "minus.circle.fill")
                        .font(.largeTitle)
                }
                .padding()

                Button(action: {
                    holeScores[currentHoleNumber - 1] += 1
                    globalScore += 1
                }) {
                    Image(systemName: "plus.circle.fill")
                        .font(.largeTitle)
                }
                .padding()
            }

            if currentHoleNumber < numberOfHoles {
                Button("Next Hole") {
                    advanceToNextHole()
                }
                .padding()
            } else {
                Button("Finish Game") {
                    // Finish game logic goes here, e.g., displaying results or resetting for a new game.
                }
                .padding()
            }
        }
    }

    private func advanceToNextHole() {
        if currentHoleNumber < numberOfHoles {
            // Proceed to next hole, but keep global score intact
            currentHoleNumber += 1
            strokes = 0 // Reset strokes for the new hole
        }
    }
}

#if DEBUG
struct HoleView_Previews: PreviewProvider {
    static var previews: some View {
        HoleView(gameType: .constant("disc"), numberOfHoles: .constant(9), parType: .constant("standard"))
    }
}
#endif
