//
//  CastroApp.swift
//  Castro
//
//  Created by Bartosz Stokrocki on 26/03/2021.
//

import SwiftUI
import GoogleCast

@main
struct CastroApp: App {
    private let castSessionManager = CastSessionManager()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
