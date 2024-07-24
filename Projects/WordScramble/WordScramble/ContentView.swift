//
//  ContentView.swift
//  WordScramble
//
//  Created by Aditya Kharbanda on 24/07/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        /// Example of some Bundle Code
        var body: some View {
            if let fileURL = Bundle.main.url(forResource: "some-file", withExtension: "txt"){
                //we found the file in our bundle
            }
            
            if let fileContents = try? String(contentsOf: fileURL){
                //we loaded the file into a String
            }
        }
    }
}
#Preview {
    ContentView()
}
