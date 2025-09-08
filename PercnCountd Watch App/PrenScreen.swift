//
//  PrenScreen.swift
//  PercnCountd
//
//  Created by TuxMan on 9/8/25.
//

import SwiftUI

struct PercentScreen: View {
    let start: Date
    let end: Date
    @State private var now = Date()

    var body: some View {
        Text(String(format: "%.6f%%", Logic.percent(start: start, end: end, now: now)))
            .font(.title2)
            .monospacedDigit()
            .padding()
            .onReceive(Timer.publish(every: 0.016667, on: .main, in: .common).autoconnect()) { now = $0 }
        
        // 0.016667 is 60fps
    }
}
