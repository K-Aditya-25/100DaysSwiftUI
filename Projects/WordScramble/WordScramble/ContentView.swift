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
    
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    var body: some View {
        NavigationStack{
            List{
                Section{
                    TextField("Enter Your Word", text: $newWord)
                        .autocorrectionDisabled()
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
            .onAppear(perform: { //runs the code in its scope just when the code compiles and app starts running
                startGame()
            })
            .alert(errorTitle, isPresented: $showingError){}message: {
                Text(errorMessage)
            }
            
        }
    }
    func addWordToList(){
        let word = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
        //exit function if new word length is 0
        guard  word.count > 0 else{return}
        
        //validate input
        guard isOriginal(word: newWord) else {
            wordError(title: "Word used already", message: "Be more original")
            return
        }

        guard isPossible(word: newWord) else {
            wordError(title: "Word not possible", message: "You can't spell that word from '\(rootWord)'!")
            return
        }

        guard isReal(word: newWord) else {
            wordError(title: "Word not recognized", message: "You can't just make them up, you know!")
            return
        }
        
        //insert word into list
        withAnimation{
            listOfWords.insert(word, at: 0)
        }
        
        //Set newWord to empty string again
        newWord = ""
    }
    
    
    /// Call This Function When The Content View Is Started
    func startGame(){
        if let startURL = Bundle.main.url(forResource: "start", withExtension: "txt"){
            if let startWords = try? String(contentsOf: startURL){
                let allWords = startWords.components(separatedBy: "\n")
                rootWord = allWords.randomElement() ?? "Butterfly"
                return
            }
        }
        fatalError("Damn, couldn't load the text file for some reason!")
    }
    
    func isOriginal(word: String) -> Bool{
        !listOfWords.contains(word)
    }
    
    func isPossible(word: String)->Bool{
        var tempWord = rootWord
        
        for letter in word{
            if let pos = tempWord.firstIndex(of: letter){
                tempWord.remove(at: pos)
            }else{
                return false
            }
        }
        return true
    }
    
    func isReal(word: String) -> Bool{
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        
        return misspelledRange.location == NSNotFound
    }
    
    func wordError(title: String, message: String){
        errorMessage = message
        errorTitle = title
        showingError = true
    }
}
#Preview {
    ContentView()
}
