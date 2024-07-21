//
//  ContentView.swift
//  BetterRest
//
//  Created by Aditya Kharbanda on 20/07/24.
//

import CoreML
import SwiftUI

struct ContentView: View {
    @State private var wakeUpTime = defaultWakeTime
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1
    
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false
    
    static var defaultWakeTime: Date{
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? .now
    }
    var body: some View {
        NavigationStack{
            Form{
                VStack(alignment: .leading ,spacing:0){
                    Text("What Time Do You Wake Up?")
                        .font(.headline)
                        .padding(.bottom)
                    DatePicker("Please Enter A Time", selection: $wakeUpTime, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                }
                VStack(alignment: .leading ,spacing:0){
                    Text("Desired Amount Of Sleep?")
                        .font(.headline)
                    Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 2...12, step: 0.25)
                }
                VStack(alignment: .leading ,spacing:0){
                    Text("Daily Coffee Intake")
                        .font(.headline)
                    Stepper("^[\(coffeeAmount) cup](inflect: true)", value: $coffeeAmount, in: 0...20)
                }
            }
            .navigationTitle("Better Rest")
            .toolbar{
                Button("Calculate", action: calculateSleepTime)
            }
            .alert(alertTitle, isPresented: $showingAlert){
                Button("OK"){}
            }message: {
                Text(alertMessage)
            }
        }
    }
    
    func calculateSleepTime(){
        do{
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUpTime)
            let hour = (components.hour ?? 0) * 60 * 60
            let minute = (components.minute ?? 0) * 60
            
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            let sleepTime = wakeUpTime - prediction.actualSleep
            
            alertTitle = "Your Ideal Bedtime Is..."
            alertMessage = sleepTime.formatted(date: .omitted, time: .shortened)
        }catch{
            alertTitle = "Error!"
            alertMessage = "Sorry, prediction failed."
        }
        showingAlert = true
    }
    
}

#Preview {
    ContentView()
}
