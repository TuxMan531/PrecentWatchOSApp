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
        Text(String(format: "%.5f%%", Logic.percent(start: start, end: end, now: now)))
            .font(.title2)
            .monospacedDigit()
            .padding()
            .onReceive(Timer.publish(every: updateRate, on: .main, in: .common).autoconnect()) { now = $0 }
        
        // 60fps is 0.016667s hello to my good friend droc101
    }
}
