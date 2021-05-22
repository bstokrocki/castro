//
//  CastroApp.swift
//  Castro WatchKit Extension
//
//  Created by Bartosz Stokrocki on 26/03/2021.
//

import SwiftUI
import WatchKit
import WatchConnectivity

@main
struct CastroApp: App {
    private let sessionDelegate = SessionDelegate()
    private var wcSession: WCSession {
        return WCSession.default
    }
    
    init() {
        wcSession.delegate = sessionDelegate
        wcSession.activate()
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView(viewModel: PlayerViewModel())
            }
        }
    }
    
    class SessionDelegate: NSObject, WCSessionDelegate {
        func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
            if activationState == WCSessionActivationState.activated {
                print("Session reachable: \(session.isReachable)")
                session.sendMessage(["Test" : "TestV"], replyHandler: nil)
            }
        }
    }
}
