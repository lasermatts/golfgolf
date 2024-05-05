//
//  golfgolfApp.swift
//  golfgolf
//
//  Created by Matt Puchalski on 4/29/24.
//

import SwiftUI

@main
struct golfgolfApp: App {
    @StateObject private var connectivityManager = ConnectivitySessionManager()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(connectivityManager)
        }
    }
}
