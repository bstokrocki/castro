//
//  CastroApp.swift
//  Castro
//
//  Created by Bartosz Stokrocki on 26/03/2021.
//

import SwiftUI
import GoogleCast
import WatchConnectivity

@main
struct CastroApp: App {
    private let castSessionManager = CastSessionManager()
    
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
            ContentView()
        }
    }
    
    class SessionDelegate: NSObject, WCSessionDelegate {
        func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
            
        }
        
        func sessionDidBecomeInactive(_ session: WCSession) {
            
        }
        
        func sessionDidDeactivate(_ session: WCSession) {
            
        }
        
        func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
            print("App received a message")
        }
    }
}
