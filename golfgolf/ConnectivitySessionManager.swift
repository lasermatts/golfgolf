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
            } else {
                self.isConnected = activationState == .activated
                if self.isConnected {
                    print("WCSession is active. Ready to send data.")
                } else {
                    print("WCSession activation incomplete, state: \(activationState)")
                }
            }
        }
    }

    #if os(iOS)
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

    func session(_ session: WCSession, didReceiveMessage message: [String : Any], replyHandler: @escaping ([String : Any]) -> Void) {
        DispatchQueue.main.async {
            // Handle message and possibly update StatsModel
            let statsModel = StatsModel.shared
            statsModel.totalScore = message["totalScore"] as? Int ?? 0
            statsModel.holeScores = message["holeScores"] as? [Int] ?? []
            statsModel.gameDuration = message["gameDuration"] as? Double ?? 0.0
            statsModel.gameDate = message["date"] as? Date ?? Date()
            
            print("Received message: \(message)")
            replyHandler(["Response": "Message received successfully!"])
        }
    }
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Setup WCSession
        if WCSession.isSupported() {
            let session = WCSession.default
            session.delegate = ConnectivitySessionManager.shared  // Assuming shared instance handling session
            session.activate()
        }
        return true
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Handle any tasks when app goes into background
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Reactivate session if needed
        let session = WCSession.default
        if session.activationState != .activated {
            session.activate()
        }
    }
    #else
    func session(_ session: WCSession, didReceiveMessage message: [String : Any], replyHandler: @escaping ([String : Any]) -> Void) {
        DispatchQueue.main.async {
            // Handle message appropriately for watchOS, without referencing StatsModel
            print("Received message on Watch: \(message)")
            replyHandler(["Response": "Message received successfully!"])
        }
    }
    #endif

    func sendGolfData(data: [String: Any]) {
        if WCSession.default.isReachable {
            WCSession.default.sendMessage(data, replyHandler: nil) { error in
                // Handle any errors that occur during the send operation
                print("Error sending golf data: \(error.localizedDescription)")
            }
        } else {
            // If the session is not reachable, log a message or handle it accordingly
            print("WCSession is not reachable. Make sure the iOS app is in the foreground or configured to receive background updates.")
        }
    }

}
