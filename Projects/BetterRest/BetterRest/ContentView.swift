//
//  ContentView.swift
//  BetterRest
//
//  Created by Aditya Kharbanda on 20/07/24.
//

import SwiftUI

struct ContentView: View {
    @State private var sleepAmount = 8.0
    @State private var wakeUp = Date.now
    var body: some View {
        Stepper("\(sleepAmount.formatted(.number)) hours of sleep", value: $sleepAmount, in: 4...12, step:0.25)
            .padding(20)
        
        DatePicker("Please select date: ", selection: $wakeUp, in: Date.now... , displayedComponents: .hourAndMinute)
            .labelsHidden()
            .padding(20)
        Text(Date.now, format: .dateTime.day().month().year())
        Text(Date.now.formatted(date: .long, time: .shortened))
    }
    
    func exampleDates(){
//        let now = Date.now
//        let tomorrow = Date.now.addingTimeInterval(86400) //no. of seconds in a day = 86400
//        let range = now...tomorrow
        
//        var components = DateComponents()
//        components.hour = 6
//        components.minute = 30
//        let date = Calendar.current.date(from: components) ?? .now
        
        let components = Calendar.current.dateComponents([.hour, .minute], from: .now)
        let hour = components.hour ?? 0
        let minute = components.minute ?? 0
        
        
        
    }
}

#Preview {
    ContentView()
}
