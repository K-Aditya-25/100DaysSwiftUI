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
    @State private var validWord = false
    
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    
    var score: Int {
    // Calculate the score based on the provided formula
            let lengthScores = listOfWords.map { word in
                let length = word.count
                return length * (length - 2)
            }
            let totalLengthScore = lengthScores.reduce(0, +)
            let numberOfWordsBonus = 2 * listOfWords.count
            
            return totalLengthScore + numberOfWordsBonus
            
    }
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
            .toolbar(content: {
                Button("Restart", action: startGame)
            })
            
            Text("Score: \(score)")
                .font(.system(size: 50))
                .foregroundStyle(.primary)
                .frame(width: .infinity, height: .infinity)
//                .background(Color(.black))
        }
    }
    func addWordToList(){
        let word = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
        //exit function if new word length is 0
        guard  word.count > 0 else{return}
        
        //validate input
        validWord = isValid(wordInUse: newWord)
        
        //insert word into list
        if validWord{
            withAnimation{
                listOfWords.insert(word, at: 0)
            }
        }
        
        //Set newWord to empty string again
        newWord = ""
    }
    
    
    /// Call This Function When The Content View Is Started
    func startGame(){
        if let startURL = Bundle.main.url(forResource: "start", withExtension: "txt"){
            if let startWords = try? String(contentsOf: startURL){
                let allWords = startWords.components(separatedBy: "\n")
                //Set root word
                rootWord = allWords.randomElement() ?? "Butterfly"
                //Empty list of words
                listOfWords = [String]()
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
    
    //Disallow answers that are shorter than three letters or are just our start word
    func isLong(word: String) -> Bool{
        word.count >= 3
    }
    
    func isNotRoot(word: String) -> Bool{
        word != rootWord
    }
    
    //Function to set error title and message
    func wordError(title: String, message: String){
        errorMessage = message
        errorTitle = title
        showingError = true
    }
    
    
    //Final Validity function to verify the validaity of the word entered
    func isValid(wordInUse:String) -> Bool{
        
        guard isOriginal(word: wordInUse) else {
            wordError(title: "Word used already", message: "Be more original")
            return false
        }
        
        guard isPossible(word: wordInUse) else {
            wordError(title: "Word not possible", message: "You can't spell that word from '\(rootWord)'!")
            return false
        }
        
        guard isReal(word: wordInUse) else {
            wordError(title: "Word not recognized", message: "You can't just make them up, you know!")
            return false
        }
        guard isLong(word: wordInUse) else{
            wordError(title: "Word is too short", message: "Try a bigger word")
            return false
        }
        guard isNotRoot(word: wordInUse) else{
            wordError(title: "Root Word", message: "You cannot submit the Root Word!")
            return false
        }
        return true
    }
}
#Preview {
    ContentView()
}
