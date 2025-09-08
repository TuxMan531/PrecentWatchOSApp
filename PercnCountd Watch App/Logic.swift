//
//  Logic.swift
//  PercnCountd
//
//  Created by TuxMan on 9/8/25.
//

import Foundation

enum Logic {
    /// Returns 0...1 progress from start→end at `now`.
    /// If `end <= start`, we treat `end` as "next day".
    static func progress(start: Date, end: Date, now: Date = Date()) -> Double {
        let endAdj = (end > start) ? end : Calendar.current.date(byAdding: .day, value: 1, to: end)!
        let duration = max(endAdj.timeIntervalSince(start), 1)     // avoid /0
        let elapsed  = now.timeIntervalSince(start)
        
        print("endAdj: \(endAdj)")
        print("duration: \(duration)%")
        print("elapsed: \(elapsed)%")
        print("start: \(start)%")
        print("end: \(end)%")
        
        return min(max(elapsed / duration, 0), 1)                  // clamp 0...1
        
    }

    static func percent(start: Date, end: Date, now: Date = Date()) -> Double {
        let v = progress(start: start, end: end, now: now) * 100.0
        return (v * 1_000_000).rounded() / 1_000_000
    }
}
