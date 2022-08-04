//
//  GirlNames.swift
//  Sexism
//
//  Created by Lem Euro on 27.07.2022.
//

import SwiftUI

struct GirlNames: View {
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""
    
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    @State private var showingSummary = false
    
    @State private var score = 0
    @State private var round = 1
    
    var body: some View {
        List {
            Section {
                Text("Make up new words from the female name, you have 10 rounds.")
            }
            
            Section {
                TextField("Enter your word", text: $newWord)
                    .autocapitalization(.none)
            }
            
            Section {
                HStack {
                    Text("Round: \(round)")
                    
                    Spacer()
                    
                    Button(round == 10 ? "Summary" : "Next Round") {
                        if round < 10 {
                            nextRound()
                        } else {
                            showingSummary = true
                        }
                    }
                }
            }
            
            Section {
                ForEach(usedWords, id: \.self) { word in
                    HStack {
                        Image(systemName: "\(word.count).circle.fill")
                        Text(word)
                    }
                }
            }
        }
        .navigationTitle(rootWord)
        .onSubmit(addNewWord)
        .onAppear(perform: startGame)
        .alert(errorTitle, isPresented: $showingError) {
            Button("OK", role: .cancel) { }
        } message: {
            Text(errorMessage)
        }
        .alert("Game Over", isPresented: $showingSummary) {
            Button("Start New Game") {
                startGame()
            }
        } message: {
            Text("Your scores is: \(score)")
        }
        .toolbar {
            Button("New Game", action: startGame)
        }
        .safeAreaInset(edge: .bottom) {
            Text("Score: \(score)")
                .frame(maxWidth: .infinity)
                .padding()
                .background(.blue)
                .foregroundColor(.white)
                .font(.title)
        }
    }
    
    func addNewWord() {
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard answer.count > 2 else {
            wordError(title: "Word too short", message: "Words must be at least three letters long.")
            return
        }
        guard answer != rootWord else {
            wordError(title: "Nice try...", message: "You can't use your starting word!")
            return
        }
        
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
        score += answer.count
    }
    
    func loadStartWord() {
        if let startWordURL = Bundle.main.url(forResource: "female", withExtension: "txt") {
            if let startWords = try? String(contentsOf: startWordURL) {
                let allWords = startWords.components(separatedBy: "\n")
                rootWord = allWords.randomElement() ?? "silkworm"
                while rootWord.count < 6 {
                    rootWord = allWords.randomElement() ?? "silkworm"
                }
                return
            }
        }
        
        fatalError("Could not load start.txt from bundle.")
    }
    
    func startGame() {
        newWord = ""
        round = 1
        score = 0
        usedWords.removeAll()
        
        loadStartWord()
    }
    
    func nextRound() {
        newWord = ""
        usedWords.removeAll()
        
        loadStartWord()
        
        round += 1
    }
    
    func isOriginal(word: String) -> Bool {
        !usedWords.contains(word)
    }
    
    func isPossible(word: String) -> Bool {
        var tempWord = rootWord.lowercased()
        
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
    
    func wordError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showingError = true
    }
}

struct GirlNames_Previews: PreviewProvider {
    static var previews: some View {
        GirlNames()
    }
}
