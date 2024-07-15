//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Aditya Kharbanda on 14/07/24.
//

import SwiftUI

//Challenge: make a view modifier with the following specifications
struct ProminentFont: ViewModifier{
    func body(content: Content) -> some View {
        content
            .fontWeight(.bold)
            .font(/*@START_MENU_TOKEN@*/.largeTitle/*@END_MENU_TOKEN@*/)
            .foregroundStyle(.blue)
    }
}

//Make a corresponding extension to View
extension View{
    func prominentFont() -> some View{
        modifier(ProminentFont())
    }
}

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
                .prominentFont()
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
