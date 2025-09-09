//
//  Logic.swift
//  PercnCountd
//
//  Created by TuxMan on 9/8/25.
//

import Foundation

struct Logic {
    /// Returns 0...1 progress from start→end at `now`.
    /// If `end <= start`, we treat `end` as "next day".
    static func progress(start: Date, end: Date, now: Date = Date()) -> Double {
        
        func clampToMinute(_ d: Date, cal: Calendar = .current) -> Date {
            cal.dateInterval(of: .minute, for: d)?.start ?? d
        }
        let ClampedStart = clampToMinute(start)
        let ClampedEnd   = clampToMinute(end)
        
        
        let endAdj = (ClampedEnd > ClampedStart) ? ClampedEnd : Calendar.current.date(byAdding: .day, value: 1, to: ClampedEnd)!
        // what this^ does is if the start date is after the end date it assumes the user is talking about the NEXT day, as in if im trying to figure out from start 11pm to 2am it doesn't just throw 100%+
        let duration = max(endAdj.timeIntervalSince(ClampedStart), 1)     // avoid /0
        let elapsed  = now.timeIntervalSince(ClampedStart)
        // let is constant and var is real let
        var giveback = elapsed / duration
        if (giveback < 0) {
         giveback = 0
        }
        if (true) { // true if debuging
            print("----------:")
            print("endAdj: \(endAdj)")
            print("duration: \(duration)")
            print("elapsed: \(elapsed)")
            print("now: \(now)")
            print("start: \(ClampedStart)")
            print("end: \(ClampedEnd)")
            print("giveback \(giveback)")
        }
        
        return giveback               // clamp 0...1
        
    }

    static func percent(start: Date, end: Date, now: Date = Date()) -> Double {
        let v = progress(start: start, end: end, now: now) * 100.0
        return v
    }
}
