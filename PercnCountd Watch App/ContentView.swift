//
//  ContentView.swift
//  PercnCountd Watch App
//
//  Created by TuxMan on 9/7/25.
//

import SwiftUI
import WatchKit


struct ContentView: View {
    @State private var showPercent = false
    @State private var start = Date()
    @State private var end   = Date()
    @State private var path = NavigationPath()
    
    var body: some View {
        VStack(spacing: 0){
            Text("Start & End Time")
                .ignoresSafeArea(.container, edges: .top)
                .padding(.horizontal)
                .padding(.top, 0)
                .frame(height: 0) // keep this I think
        }
        // SYSTEM-STYLE FORM
        NavigationStack(path: $path) {
            ZStack(alignment: .top) {
                    VStack(spacing: 0) {
                        DatePicker("Start", selection: $start, displayedComponents: [.hourAndMinute])
                        DatePicker("End",   selection: $end, displayedComponents: [.hourAndMinute])
                    }
                    .padding(.top, -40)
                    .padding(.bottom, 10)
            }

            // BOTTOM ACTIONS
            .safeAreaInset(edge: .bottom) {
                Button("Start") {
                    let pct = Logic.percent(start: start, end: end)
                    print("Progress: \(pct)%")
                    WKInterfaceDevice.current().play(.click)
                    showPercent = true
                }
                .tint(.green)
                .padding(.horizontal)
                .padding(.bottom, -35) // space from bottom safe area
                .ignoresSafeArea(.container, edges: .bottom).sheet(isPresented: $showPercent) {
                PercentScreen(start: start, end: end)
                    }
                }
            }
        }
    }

#Preview {
    ContentView()
}
