//
//  ConnectivitySessionManager.swift
//  golfgolf
//
//  Created by Matt Puchalski on 5/4/24.
//

import Foundation
import SwiftUI
import WatchConnectivity

class ConnectivitySessionManager: NSObject, WCSessionDelegate, ObservableObject {
    @Published var isConnected = false
    @Published var lastError: String?

    static let shared = ConnectivitySessionManager()

    override init() {
        super.init()
        if WCSession.isSupported() {
            let session = WCSession.default
            session.delegate = self
            session.activate()
        }
    }

    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        DispatchQueue.main.async {  // Ensure UI updates are on the main thread
            if let error = error {
                self.lastError = "Activation failed: \(error.localizedDescription)"
                self.isConnected = false
                print(self.lastError ?? "Unknown error")
            } else {
                self.isConnected = activationState == .activated
                print("WCSession activated with state: \(activationState.rawValue)")
            }
        }
    }

    func sessionDidBecomeInactive(_ session: WCSession) {
        DispatchQueue.main.async {
            self.isConnected = false
            print("WCSession has become inactive.")
        }
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        DispatchQueue.main.async {
            self.isConnected = false
            print("WCSession has been deactivated.")
            session.activate()  // Reactivate to prepare for new session setup
        }
    }

    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        DispatchQueue.main.async {
            // Handle incoming message from the Watch
            print("Received message: \(message)")
        }
    }
}


