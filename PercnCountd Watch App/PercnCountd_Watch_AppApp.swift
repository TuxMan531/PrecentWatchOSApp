//
//  PercnCountdApp.swift
//  PercnCountd Watch App
//
//  Created by TuxMan on 9/7/25.
//

import SwiftUI

@main
struct PercnCountd_Watch_AppApp: App {
    @Environment(\.scenePhase) private var scenePhase

    var body: some Scene {
        WindowGroup { ContentView() }
            .onChange(of: scenePhase) { oldPhase, newPhase in
                switch newPhase {
                case .active: // resumed
                    updateRate = 1/30
                case .inactive: // about to leave (Crown press, app switcher, alert on top)
                    break
                case .background: // now in background; save state, stop work
                    updateRate = 5
                @unknown default: break
                }
            }
    }
}
