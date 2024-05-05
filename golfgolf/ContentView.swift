//
//  ContentView.swift
//  golfgolf
//
//  Created by Matt Puchalski on 4/29/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @EnvironmentObject var connectivityManager: ConnectivitySessionManager

    @State private var gameType: String = "disc" // default to disc golf
    @State private var numberOfHoles: Int = 9 // default to 9 holes
    @State private var parType: String = "standard" // default to standard par

    var body: some View {
        NavigationView {
            Form {
                Section {
                    NavigationLink(destination: StatsView()) {
                        HStack {
                            Image(systemName: "chart.bar")
                                .foregroundColor(.green)
                            Text("View Stats")
                                .fontWeight(.bold)
                        }
                        .frame(maxWidth: .infinity, alignment: .center)
                    }
                    .buttonStyle(PlainButtonStyle()) // Use PlainButtonStyle for better customization
                }

                Section(header: Text("Connection Status")) {
                    if connectivityManager.isConnected {
                        Label("Connected", systemImage: "checkmark.circle.fill")
                            .foregroundColor(.green)
                    } else {
                        Label("Not Connected", systemImage: "xmark.circle.fill")
                            .foregroundColor(.red)
                    }
                    
                    if let error = connectivityManager.lastError {
                        Text("Error: \(error)")
                            .foregroundColor(.red)
                            .font(.caption)
                    }
                }
                
                Section(header: Text("Game Type")) {
                    Picker("Select Game Type", selection: $gameType) {
                        Text("Ball Golf").tag("ball")
                        Text("Disc Golf").tag("disc")
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Number of Holes")) {
                    Picker("Select Number of Holes", selection: $numberOfHoles) {
                        Text("9 Holes").tag(9)
                        Text("18 Holes").tag(18)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Par Configuration")) {
                    Picker("Select Par Type", selection: $parType) {
                        Text("Standard Par 3").tag("standard")
                        Text("Custom Par").tag("custom")
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                NavigationLink(destination: HoleView(gameType: $gameType, numberOfHoles: $numberOfHoles, parType: $parType)) {
                    Text("Start Game")
                }
            }
            .navigationBarTitle("GolfGolf")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ConnectivitySessionManager())
    }
}
