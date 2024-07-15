//
//  ContentView.swift
//  WeSplit
//
//  Created by Aditya Kharbanda on 11/07/24.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numPeople = 2
    @State private var tipPercentage = 20
    @FocusState private var amountIsFocused: Bool
    
    private var totalAmount: Double{
        checkAmount * (1.0 + Double(tipPercentage) / 100.0)
    }
    
    private var perPersonTip: Double{
        let persons = Double(numPeople) + 2.0 //Add 2 because of ForEach loop for number of people
        return totalAmount / persons
    }
    
    let tipPercentages = [5, 10, 15, 20, 0]
    
    var body: some View {
        NavigationStack{
            Form{
                Section{
                    TextField("Bill Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    Picker("Number Of People", selection: $numPeople){
                        ForEach(2..<21){
                            Text("\($0)")
                        }
                    }
                        .pickerStyle(.navigationLink)
                }
                
                Section("How Much Do You Want To Tip?"){
                    Picker("Tipping Percentage", selection: $tipPercentage){
                        ForEach(tipPercentages, id: \.self){
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section("Total Amount"){
                    Text(totalAmount, format: .currency(code: Locale.current.currency?.identifier ?? "INR"))
                    //challenge for Project 3: Add Custom Modifier
                        .foregroundStyle(tipPercentage == 0 ? .red : .black)
                }
                
                Section("Amount Per Person"){
                    Text(perPersonTip, format: .currency(code: Locale.current.currency?.identifier ?? "INR"))
                }
                
            }
            .navigationTitle("WeSplit")
            .toolbar{
                if amountIsFocused{
                    Button("Done"){
                        amountIsFocused = false
                    }
                }
            }
        }
        
    }
}

#Preview {
    ContentView()
}
