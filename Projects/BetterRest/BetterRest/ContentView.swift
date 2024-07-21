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
//    @State private var showingAlert = false
    
    static var defaultWakeTime: Date{
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? .now
    }
    
    private var actualTime: Date{
        calculateSleepTime()
    }
    
    var body: some View {
        VStack{
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
    //                    Stepper("^[\(coffeeAmount) cup](inflect: true)", value: $coffeeAmount, in: 0...20)
                        Picker("How Many cup(s) of coffee?", selection: $coffeeAmount){
                            ForEach(0..<11){
                                Text("^[\($0) cup](inflect: true)")
                                    
                            }
                        }
                        .pickerStyle(.wheel)
                    }
                }
                .navigationTitle("Better Rest")
    //            .toolbar{
    //                Button("Calculate", action: calculateSleepTime)
    //            }
    //            .alert(alertTitle, isPresented: $showingAlert){
    //                Button("OK"){}
    //            }message: {
    //                Text(alertMessage)
    //            }
            }
            Text("Your Ideal Bedtime Is...")
                .font(.largeTitle)
                .fontWeight(.semibold)
            ZStack{
                Rectangle()
                    .frame(width: 200, height: 100)
                    .cornerRadius(10)
                    .foregroundStyle(.thinMaterial)
                    .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                Text("\(actualTime.formatted(date: .omitted, time: .shortened))")
                    .foregroundStyle(.primary)
                    .bold()
                    .font(.largeTitle)
            }
            
            
        }
        
        
    }
    
    func calculateSleepTime() -> Date{
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
//            showingAlert = true
            return sleepTime
        }catch{
            alertTitle = "Error!"
            alertMessage = "Sorry, prediction failed."
//            showingAlert = true
            
        }
        //should not execute ideally
        return Date.now
    }
    
}

#Preview {
    ContentView()
}
