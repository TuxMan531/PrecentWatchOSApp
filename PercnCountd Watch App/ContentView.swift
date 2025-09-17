import SwiftUI
import WatchKit
var updateRate: Double = 1/30 // trust

struct ContentView: View {
    @State private var start = Date()
    @State private var end   = Date()
    @State private var showPercent = false   // controls which view on page 1
    @State private var tab = 0               // 0 = setup, 1 = result/wait

    var body: some View {
        TabView(selection: $tab) {
            // PAGE 0: setup
            NavigationStack {
                VStack(spacing: 0){
                    Text("Start & End Time")
                        .ignoresSafeArea(.container, edges: .top)
                        .padding(.horizontal)
                        .padding(.top, 0)
                        .frame(height: 0) // keep this I think
                }
                
                ZStack(alignment: .top) {
                    VStack(spacing: 0) {
                        DatePicker("Start", selection: $start, displayedComponents: [.hourAndMinute])
                        DatePicker("End",   selection: $end,   displayedComponents: [.hourAndMinute])
                    }
                    .padding(.top, 0)
                    .padding(.bottom, 10)
                }
                .safeAreaInset(edge: .bottom) {
                    Button("Start") {
                        _ = Logic.percent(start: start, end: end)
                        WKInterfaceDevice.current().play(.click)
                        showPercent = true          // choose content for page 1
                        tab = 1                     // go to page 1
                    }
                    .tint(.green)
                    .padding(.horizontal)
                    .padding(.bottom, -35)
                    .ignoresSafeArea(.container, edges: .bottom)
                }
            }
            .tag(0)

            // PAGE 1: either wait or percent
            ZStack {
                if showPercent {
                    PercentScreen(start: start, end: end)
                        .transition(.opacity)
                } else {
                    WaitPrenScreen(start: start, end: end)
                        .transition(.opacity)
                }
            }
            .animation(.default, value: showPercent)
            .id(showPercent)   // force rebuild
            .tag(1)
        }
        .tabViewStyle(.page)
        .indexViewStyle(.page(backgroundDisplayMode: .automatic))
    }
}

