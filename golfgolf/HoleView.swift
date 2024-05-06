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
    @State private var holeScores: [Int]
    
    init(gameType: Binding<String>, numberOfHoles: Binding<Int>, parType: Binding<String>) {
        self._gameType = gameType
        self._numberOfHoles = numberOfHoles
        self._parType = parType
        self._holeScores = State(initialValue: Array(repeating: 0, count: numberOfHoles.wrappedValue))
    }

    var body: some View {
        NavigationView {
            VStack {
                Text("Playing \(gameType) - \(parType) Par")
                    .font(.headline)

                Spacer()
                
                Text("Hole \(currentHoleNumber) of \(numberOfHoles)")
                    .font(.title)

                Text("Strokes: \(holeScores[currentHoleNumber - 1])")
                    .font(.title2)

                Text("Global Score: \(globalScore)")
                    .font(.title2)

                HStack {
                    Button(action: decrementStroke) {
                        Image(systemName: "minus.circle.fill")
                            .font(.largeTitle)
                    }
                    .padding()

                    Button(action: incrementStroke) {
                        Image(systemName: "plus.circle.fill")
                            .font(.largeTitle)
                    }
                    .padding()
                }
                
                Spacer()
                
                Button("Next Hole", action: advanceToNextHole)
                    .buttonStyle(FilledButton())
                    .disabled(currentHoleNumber == numberOfHoles)

                Button("Finish Game", action: finishGame)
                    .buttonStyle(FilledButton())
                    .padding()
                    .opacity(currentHoleNumber == numberOfHoles ? 1 : 0)
            }
            .navigationBarTitle("Hole \(currentHoleNumber) Details", displayMode: .inline)
            .padding()
        }
    }

    private func decrementStroke() {
        if holeScores[currentHoleNumber - 1] > 0 {
            holeScores[currentHoleNumber - 1] -= 1
            globalScore -= 1
        }
    }

    private func incrementStroke() {
        holeScores[currentHoleNumber - 1] += 1
        globalScore += 1
    }

    private func advanceToNextHole() {
        if currentHoleNumber < numberOfHoles {
            currentHoleNumber += 1
            strokes = 0  // Reset strokes for the new hole
        }
    }

    private func finishGame() {
        // Logic to handle end of the game, potentially saving the results and navigating to StatsView
        print("Game Finished! Total Score: \(globalScore)")
        // Implement navigation to StatsView here
    }
}

struct FilledButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

#if DEBUG
struct HoleView_Previews: PreviewProvider {
    static var previews: some View {
        HoleView(gameType: .constant("Disc Golf"), numberOfHoles: .constant(9), parType: .constant("Standard"))
    }
}
#endif
