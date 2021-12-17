//
//  Covid_TrackingApp.swift
//  Covid Tracking
//
//  Created by Matthew Jiang on 2021/11/13.
//

import SwiftUI

@main

struct Covid_TrackingApp: App {
    
    @StateObject var manager = CovidManager()
    var body: some Scene {
        
        WindowGroup {
            ContentView()
                .environmentObject(manager)
        }
    }
}
