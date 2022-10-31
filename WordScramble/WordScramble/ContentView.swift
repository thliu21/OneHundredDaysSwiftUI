//
//  ContentView.swift
//  WordScramble
//
//  Created by Tianhao Liu on 10/31/22.
//

import SwiftUI

struct ContentView: View {
    @State private var usedWords = [String]()
    @State private var newWord = ""
    @State private var rootWord = ""
    
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    TextField("Enter Your Word", text: $newWord) {
                        addNewWord(newWord)
                    }
                    .autocapitalization(.none)
                }
                
                Section {
                    ForEach(usedWords, id: \.self) { word in
                        HStack {
                            Image(systemName: "\(word.count).circle")
                            Text(word)
                        }
                    }
                }
            }
            .navigationTitle(rootWord)
            .alert(isPresented: $showingError) {
                Alert(
                    title: Text(errorTitle),
                    message: Text(errorMessage),
                    dismissButton: .default(Text("Okay"))
                )
            }
        }
        .onAppear(perform: startGame)
    }
    
    private func addNewWord(_ word: String) {
        let answer = word.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
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
        
        withAnimation {
            usedWords.insert(answer, at: 0)
        }
        newWord = ""
    }
    
    private func startGame() {
        guard let fileURL = Bundle.main.url(forResource: "start", withExtension: "txt"),
              let startWords = try? String(contentsOf: fileURL)
        else {
            fatalError("Failed to load start.txt")
        }
        
        let allWords = startWords.split(separator: "\n")
        rootWord = String(allWords.randomElement() ?? "wormwood")
    }
}

extension ContentView {
    private func isOriginal(word: String) -> Bool {
        !usedWords.contains(word)
    }
    
    private func isPossible(word: String) -> Bool {
        var tempWord = rootWord
        for char in word {
            if let index = tempWord.firstIndex(of: char) {
                tempWord.remove(at: index)
            } else {
                return false
            }
        }
        return true
    }
    
    private func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(
            in: word, range: range, startingAt: 0, wrap: false, language: "en"
        )
        return misspelledRange.location == NSNotFound
    }
    
    private func wordError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showingError = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
