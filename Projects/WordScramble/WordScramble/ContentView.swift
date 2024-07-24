//
//  ContentView.swift
//  WordScramble
//
//  Created by Aditya Kharbanda on 24/07/24.
//

import SwiftUI

struct ContentView: View {
    let names = "Aditya Siddharth Anu Bharat"
    let letters = ["a", "b", "c"]
    let animal = "    cat       "
    let testWord = "best"
    var body: some View {
        
        List{
            Section("Separate Strings"){
                ForEach(separateStrings(names), id: \.self){
                    Text("\($0)")
                }
            }
            Section("Random String"){
                Text(randomString(from: letters))
            }
            Section("Remove White Space"){
                Text(trimWhiteSpace(in: animal))
            }
            
            Section("Test Spelling"){
                Text(String(spellCheck(testWord)))
            }
        }
        
    }
    func separateStrings(_ string: String) -> [String]{
       string.components(separatedBy: " ")
    }
    
    func randomString(from array: [String]) -> String{
        array.randomElement() ?? "Error"//This gives an optional value
    }
    
    func trimWhiteSpace(in string: String) -> String{
        string.trimmingCharacters(in: .whitespacesAndNewlines) //check for more options by only typing the dot
    }
    
    func spellCheck(_ string: String) -> Bool{
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: testWord.utf16.count)
        let missplledRange = checker.rangeOfMisspelledWord(in: testWord, range: range, startingAt: 0, wrap: false, language: "en") //Objective C did not have a concept of Optional. If no spelling mistake is found, it will return NSNotFound
        
        //Address NSNotFound
        let allGood = missplledRange.location == NSNotFound
        return allGood
    }
}
#Preview {
    ContentView()
}
