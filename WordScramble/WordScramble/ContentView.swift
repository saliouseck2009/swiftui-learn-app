//
//  ContentView.swift
//  WordScramble
//
//  Created by saliou seck on 05/02/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    
    var body: some View {
        NavigationStack{
            Form{
                Section{
                    TextField("Enter your word",text: $newWord)
                        .textInputAutocapitalization(.never)
                }
                Section("Score"){
                    Text(usedWords.count.formatted())
                }
                Section{
                    ForEach(usedWords,id: \.self){ word in
                        HStack{
                            Image(systemName: ("\(word.count).circle"))
                            Text(word)
                        }
                        
                    }
                }
               
                
            }
            .navigationTitle(rootWord)
            .onSubmit(addWord)
            .onAppear(perform: startGame)
            .alert(errorTitle, isPresented: $showingError) {
                Button("OK") { }
            } message: {
                Text(errorMessage)
            }
            .toolbar{
                Button("Start Game",action: startGame )
            }
            
        }
        
    }
    
    func addWord(){
        var answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        guard answer.count > 0 else { return }
        
        guard isOriginal(word: answer) else {
            wordError(title: "Word used already", message: "Be more original")
            return
        }

        guard isPossible(word: answer) else {
            wordError(title: "Word not possible", message: "You can't spell that word from '\(rootWord)'!")
            return
        }

        guard isReal(word: answer) else {
            wordError(title: "Word not recognized", message: "You can't just make them up, you know!")
            return
        }
        guard isMoreThanTwoCharacters(word: answer) else {
            wordError(title: "Word too short", message: "Word can't be less than three character")
            return
        }
        
        guard isNotStart(with: answer) else {
            wordError(title: "Is the start word", message: "Answer can't be the starting word")
            return
        }
        
        withAnimation{
            usedWords.insert(answer, at: 0)
        }
        
        newWord = ""
    }
    func wordError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showingError = true
    }
    
    func startGame() {

    // 1. Find the URL for start.txt in our app bundle
    if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
        // 2. Load start.txt into a string
        if let startWords = try? String(contentsOf: startWordsURL) {
            // 3. Split the string up into an array of strings, splitting on line breaks
            let allWords = startWords.components(separatedBy: "\n")

            // 4. Pick one random word, or use "silkworm" as a sensible default
            rootWord = allWords.randomElement() ?? "silkworm"

            // If we are here everything has worked, so we can exit
            return
        }
    }

    // If were are *here* then there was a problem – trigger a crash and report the error
    fatalError("Could not load start.txt from bundle.")
    }
    
    func isOriginal(word: String) -> Bool {
        !usedWords.contains(word)
    }
    
    func isPossible(word: String) -> Bool {
        var tempWord = rootWord

        for letter in word {
            if let pos = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: pos)
            } else {
                return false
            }
        }

        return true
    }
    
    func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")

        return misspelledRange.location == NSNotFound
    }
    func isMoreThanTwoCharacters( word: String) -> Bool {
        return word.count > 2
    }
    func isNotStart(with: String) -> Bool {
        return !rootWord.hasPrefix(with)
    }
}

#Preview {
    ContentView()
}
