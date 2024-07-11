//
//  ContentView.swift
//  Challenge1
//
//  Created by Aditya Kharbanda on 11/07/24.
//

import SwiftUI

struct ContentView: View {
    let units: [String] = ["Celcius", "Farenheit", "Kelvin"]
    @State private var inputUnit : String = "Celcius"
    @State private var outputUnit : String = "Farenheit"
    @State private var inputTemp: Double = 0.0
    private var outputTemp: Double{
        if inputUnit == "Celcius" && outputUnit == "Farenheit"{
            return (9.0/5.0)*inputTemp + 32.0
        }
        else if inputUnit == "Farenheit" && outputUnit == "Celcius"{
            return (inputTemp - 32.0) / (9.0/5.0)
        }
        else if inputUnit == "Farenheit" && outputUnit == "Kelvin"{
            return (inputTemp + 459.67) * (5.0/9.0)
        }
        else if inputUnit == "Kelvin" && outputUnit == "Farenheit"{
            return (inputTemp * (9.0/5.0)) - 459.67
        }
        else if inputUnit == "Kelvin" && outputUnit == "Celcius"{
            return inputTemp - 273.15
        }
        else if inputUnit == "Celcius" && outputUnit == "Kelvin"{
            return inputTemp + 273.15
        }
        else{
            return 0.0
        }
    }
    
    @FocusState private var tempInFocus: Bool
    
    var body: some View {
        NavigationStack{
            Form{
                Section("Choose Input Unit"){
                    //Input unit selection
                    Picker("Input Unit", selection: $inputUnit){
                        ForEach(units, id: \.self){
                            Text("\($0)")
                        }
                    }
                    .pickerStyle(.segmented)
                    
                }
                
                Section("Choose Output Unit"){
                    //Output unit selection
                    Picker("Output Unit", selection: $outputUnit){
                        ForEach(units, id: \.self){
                            Text("\($0)")
                        }
                    }
                    .pickerStyle(.segmented)
                }
                Section("Enter Temperature in \(inputUnit)"){
                    //Input Temperature Value
                    TextField("Input Temperature", value: $inputTemp, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($tempInFocus)
                }
                
                Section("Converted Temperature in \(outputUnit)"){
                    //Output Temperature Value
                    Text(String(format: "%.2f", outputTemp))
                }
            }
            .navigationTitle("Temperatures")
            .toolbar{
                if tempInFocus{
                    Button("Done"){
                        tempInFocus = false
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
