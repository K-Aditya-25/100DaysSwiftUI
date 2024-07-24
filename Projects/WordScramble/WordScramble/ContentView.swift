//
//  ContentView.swift
//  WordScramble
//
//  Created by Aditya Kharbanda on 24/07/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        List(1..<5){
            Text("Number \($0)")
        }
        .listStyle(.automatic)
        
        List{
            Section("Static Rows"){
                Text("hi!")
                Text("hi!")
                Text("hi!")
                Text("hi!")
            }
            Section("Dynamic Rows"){
                ForEach(1..<6){
                    Text("Hey \($0)!")
                }
            }
            
        }
    }
}

#Preview {
    ContentView()
}
