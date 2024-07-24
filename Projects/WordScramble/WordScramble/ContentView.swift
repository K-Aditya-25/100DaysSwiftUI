//
//  ContentView.swift
//  WordScramble
//
//  Created by Aditya Kharbanda on 24/07/24.
//

import SwiftUI

struct ContentView: View {
    @State private var rootWord = ""
    @State private var listOfWords = [String]()
    @State private var newWord = ""
    var body: some View {
        NavigationStack{
            List{
                Section{
                    TextField("Enter Your Word", text: $newWord)
                        .textInputAutocapitalization(.never)
                }
                Section{
                    ForEach(listOfWords, id: \.self){ word in
                        HStack{
                            Image(systemName: "\(word.count).circle")
                            Text("\(word)")
                        }
                        
                    }
                }
            }
            .navigationTitle(rootWord)
            .onSubmit(addWordToList) //onSubmit takes a function that has no parameters and returns nothing
            
        }
    }
    func addWordToList(){
        let word = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
        //exit function if new word length is 0
        guard  word.count > 0 else{return}
        
        //insert word into list
        withAnimation{
            listOfWords.insert(word, at: 0)
        }
        
        //Set newWord to empty string again
        newWord = ""
    }
}
#Preview {
    ContentView()
}
