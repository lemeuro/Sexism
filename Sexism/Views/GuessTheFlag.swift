//
//  GuessTheFlag.swift
//  Sexism
//
//  Created by Lem Euro on 30.07.2022.
//

import SwiftUI

struct TitleModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundStyle(.blue)
    }
}

extension View {
    func title() -> some View {
        modifier(TitleModifier())
    }
}

struct CornerRotateModifier: ViewModifier {
    let amount: Double
    let anchor: UnitPoint
    
    func body(content: Content) -> some View {
        content
            .rotationEffect(.degrees(amount), anchor: anchor)
            .clipped()
    }
}

//extension AnyTransition {
//    static var pivot: AnyTransition {
//        .modifier(
//            active: CornerRotateModifier(amount: -90, anchor: .topLeading),
//            identity: CornerRotateModifier(amount: 0, anchor: .topLeading))
//    }
//}

struct GuessTheFlag: View {
    let countries: [Country] = Bundle.main.decode("countries.json")
    let country: Country
    
    @State private var flags = [String]()
    @State private var selectedFlag = ""
    @State private var disableButton = false
    
    @State private var questionCounter = 1
    @State private var showingScore = false
    @State private var scoreTitle = ""
//    @State private var showingResults = false
//    @State private var score = 0
    
//    @State private var countries = allCountries.shuffled()
//    @State private var correctAnswer = Int.random(in: 0...2)
    
//    @State private var selectedFlag = -1
//    @State private var isShowingMaterial = false
    
//    static let allCountries = ["de", "gb", "fr", "be", "es", "ie", "it", "nl", "pl", "se"]
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.1),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.1)
            ], center: .top, startRadius: 200, endRadius: 700)
                .ignoresSafeArea()
            
            VStack {
//                Spacer()
                
                Text("Guess the Flag")
//                    .font(.largeTitle.bold())
                    .font(.body.bold())
                    .foregroundColor(.white)
                
                VStack(spacing: 15) {
//                    VStack {
//                        Text("Tap the flag of")
//                            .foregroundStyle(.secondary)
//                            .font(.subheadline.weight(.heavy))
//
//                        Text(countries[correctAnswer])
//                            .font(.largeTitle.weight(.semibold))
//                    }
//
//                    ForEach(0..<3) { number in
//                        Button {
//                            flagTapped(number)
//                        } label: {
//                            FlagImage(name: countries[number])
//                                .rotation3DEffect(.degrees(selectedFlag == number ? 360 : 0), axis: (x: 0, y: 1, z: 0))
//                                .opacity(selectedFlag == -1 || selectedFlag == number ? 1 : 0.25)
//                                .scaleEffect(selectedFlag == -1 || selectedFlag == number ? 1 : 0.75)
//                                .saturation(selectedFlag == -1 || selectedFlag == number ? 1: 0)
//                                .blur(radius: selectedFlag == -1 || selectedFlag == number ? 0 : 3)
//                                .animation(.default, value: selectedFlag)
//                        }
//                    }
                    
                    ForEach(flags, id: \.self) { name in
//                        Button {
//                            flagTapped(name)
//                        } label: {
//                            FlagImage(name: name)
//                                .rotation3DEffect(.degrees(selectedFlag == name ? 360 : 0), axis: (x: 0, y: 1, z: 0))
//                                .opacity(selectedFlag == -1 || selectedFlag == name ? 1 : 0.25)
//                                .scaleEffect(selectedFlag == -1 || selectedFlag == name ? 1 : 0.75)
//                                .saturation(selectedFlag == -1 || selectedFlag == name ? 1: 0)
//                                .blur(radius: selectedFlag == -1 || selectedFlag == name ? 0 : 3)
//                                .animation(.default, value: selectedFlag)
//                        }
                        Button {
                            flagTapped(name)
                        } label: {
                            FlagImage(name: name)
                                .rotation3DEffect(.degrees(selectedFlag == name ? 360 : 0), axis: (x: 0, y: 1, z: 0))
                                .opacity(selectedFlag == "" || selectedFlag == name ? 1 : 0.25)
                                .scaleEffect(selectedFlag == "" || selectedFlag == name ? 1 : 0.75)
                                .saturation(selectedFlag == "" || selectedFlag == name ? 1: 0)
                                .blur(radius: selectedFlag == "" || selectedFlag == name ? 0 : 3)
                                .animation(.default, value: selectedFlag)
                        }
                        .disabled(disableButton)
                    }
                    
                    
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
//                Spacer()
//                Spacer()
//
//                ZStack {
//                    Rectangle()
//                        .fill(.gray)
//                        .frame(width: 200, height: 100)
//
//                    if isShowingMaterial {
//                        Rectangle()
//                            .fill(.indigo)
//                            .frame(width: 200, height: 100)
//                            .transition(.pivot)
//                    }
//
//                    Text("Score \(score)")
//                        .foregroundColor(.white)
//                        .font(.title.bold())
//                }
//                .onTapGesture {
//                    withAnimation {
//                        isShowingMaterial.toggle()
//                    }
//                }
//
//                Spacer()
            }
            .padding()
            .onAppear(perform: flagsArray)
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: flagsArray)
        }
//        .alert(scoreTitle, isPresented: $showingScore) {
//            Button("Continue", action: askQuestion)
//        } message: {
//            Text("Your score is \(score)")
//        }
//        .alert("Game over!", isPresented: $showingResults) {
//            Button("Start Again", action: newGame)
//        } message: {
//            Text("Your final score was \(score)")
//        }
    }
    
//    func flagTapped(_ number: Int) {
//        selectedFlag = number
//
//        if number == correctAnswer {
//            scoreTitle = "Correct"
//            score += 1
//        } else {
//            let needsThe = ["UK", "US"]
//            let theirAnswer = countries[number]
//
//            if needsThe.contains(theirAnswer) {
//                scoreTitle = "Wrong! That's the flag of the \(theirAnswer)"
//            } else {
//                scoreTitle = "Wrong! That's the flag of \(theirAnswer)"
//            }
//            if score > 0 {
//                score -= 1
//            }
//        }
//
//        if questionCounter == 8 {
//            showingResults = true
//        } else {
//            showingScore = true
//        }
//    }
    
//    func askQuestion() {
//        countries.remove(at: correctAnswer)
//        countries.shuffle()
//        correctAnswer = Int.random(in: 0...2)
//        questionCounter += 1
//        selectedFlag = -1
//    }
    
//    func newGame() {
//        questionCounter = 0
//        score = 0
//        countries = Self.allCountries
//        askQuestion()
//    }
        
    func flagTapped(_ name: String) {
        selectedFlag = name
        
        if name == country.id {
            disableButton = true
        } else {
            var correctCountryName = ""
            for country in countries {
                if name == country.id {
                    correctCountryName = country.name
                }
            }
            scoreTitle = "Wrong! That's the flag of \(correctCountryName)"
            showingScore = true
        }
    }
    
    func flagsArray() {
        selectedFlag = ""
        disableButton = false
        flags.removeAll()
        flags.append(country.id)

        while flags.count < 3 {
            let randomFlag = countries[Int.random(in: 0..<countries.count)].id
            
            if !flags.contains(randomFlag) {
                flags.append(randomFlag)
            }
        }
        flags.shuffle()
    }
}

struct GuessTheFlag_Previews: PreviewProvider {
    static let countries: [Country] = Bundle.main.decode("countries.json")
    
    static var previews: some View {
        GuessTheFlag(country: countries[0])
    }
}
