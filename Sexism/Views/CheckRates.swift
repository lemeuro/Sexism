//
//  CheckRates.swift
//  Sexism
//
//  Created by Lem Euro on 02.08.2022.
//

import SwiftUI

struct CheckRates: View {
    let ratePerHour = 10
    let goals = [10, 15, 20, 25]
    let girlfriend = 20
    let smarty = 10
    let speakRussian = 5
    
    var rateCalculated: Int {
        ratePerHour + difficulty
    }
    
    @State private var isGameActive = false
    @State private var difficulty = 7
    @State private var numberOfQuestions = 5
    @State private var score = 0
    @State private var round = 0
    
    @State private var rate = 0
    @State private var answer = 0
    @State private var answers = [Int]()
    @State private var correctAnswer = 0
    @State private var question = ""
    @State private var answerStatus = ""
    @State private var selectedAnswer = -1
    
    @State private var animateGradient = false
    @State private var answerColorAnimation = 0
    @State private var animationScale = 1.0
    @State private var blurAnim = false
    @State private var scoreAnimation = 1.0
    @State private var scoreScale = 1.0
    @State private var rotationAnim = 0.0
    @State private var dragAmount = CGSize.zero
    @State private var enabled = false
    @State private var dragAmountButton = CGSize.zero
    @State private var isShowingSmile = false
    
    @State private var disableAnswers = false
    
    var body: some View {
        NavigationView {
            ZStack {
                AngularGradient(colors: [.green, .yellow, .red, .blue, .indigo, .green, .mint, .yellow, .white, .pink, .brown], center: .bottomTrailing, startAngle: animateGradient ? .degrees(190) : .degrees(90), endAngle: .degrees(360))
                .ignoresSafeArea()
                
                if isGameActive {
                    ZStack {
                    VStack {
                        Text("x\(difficulty)")
                            .font(.title2.bold())
                        
                        Spacer()
                        
                        VStack {
                            Text("How much\nyou should pay?")
                                .font(.title.bold())
                                .textCase(.uppercase)
                            
                            VStack {
                                Text(question)
                                    .font(.body)
                                
                                Divider()
                                Text("Question \(round) / \(numberOfQuestions)")
                            }
                        }
                        .padding()
                        .background(.thinMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        .shadow(radius: 15)
                        
                        Text(answerStatus)
                            .padding()
                            .background(.thinMaterial)
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                            .shadow(radius: 15)
                            .font(.title3)
                            .foregroundColor(answerColorAnimation == 0 ? .primary : answerColorAnimation == 1 ? .green : .red)
                        
                        HStack {
                            ForEach(0..<answers.count, id: \.self) { number in
                                Button(String(answers[number])) {
                                    checkAnswer(number: answers[number])
                                    withAnimation {
                                        rotationAnim += 360
                                    }
                                }
                                .frame(width: 60, height: 60)
                                .foregroundColor(.white)
                                .background(enabled ? .cyan : .indigo)
                                .clipShape(Circle())
                                .shadow(radius: 15)
                                .disabled(disableAnswers)
                                .scaleEffect(selectedAnswer == answers[number] ? animationScale : 1.0)
                                .blur(radius: selectedAnswer == answers[number] && blurAnim ? 2 : 0)
                                .animation(.default, value: blurAnim)
                                .rotation3DEffect(.degrees(selectedAnswer == answers[number] && answerColorAnimation == 1 ? rotationAnim : 0), axis: (x: 0, y: 1, z: 0))
                                .offset(dragAmountButton)
                                .animation(
                                    .default.delay(Double(number) / 20),
                                    value: dragAmountButton)
                            }
                        }
                        .padding()
                        .gesture(
                            DragGesture()
                                .onChanged { dragAmountButton = $0.translation}
                                .onEnded { _ in
                                    dragAmountButton = .zero
                                    enabled.toggle()
                                }
                        )
                        
                        Spacer()
                        
                        Text("Scores \(score)")
                            .padding(40)
                            .background(.thinMaterial)
                            .foregroundStyle(.primary)
                            .shadow(radius: 15)
                            .clipShape(Circle())
                            .overlay(Circle()
                                .stroke(.thinMaterial)
                                .scaleEffect(scoreAnimation)
                                .opacity(1.5 - scoreAnimation)
                                .animation(
                                    .easeInOut(duration: 1)
                                    .repeatForever(autoreverses: false),
                                    value: scoreAnimation
                                )
                            )
                            .onAppear {
                                scoreAnimation = 1.5
                            }
                            .scaleEffect(scoreScale)
                            .animation(.interpolatingSpring(stiffness: 50, damping: 1), value: scoreScale)
                            .offset(dragAmount)
                            .gesture(
                                DragGesture()
                                    .onChanged { dragAmount = $0.translation}
                                    .onEnded { _ in
                                        withAnimation {
                                            dragAmount = .zero
                                        }
                                    }
                            )
                        
                        Spacer()
                        
                        if round == numberOfQuestions {
                            
                            Button("Start New Game!") {
                                withAnimation {
                                    animateGradient.toggle()
                                    isGameActive.toggle()
                                }
                            }
                            .padding()
                            .foregroundColor(.white)
                            .background(.indigo)
                            .clipShape(Capsule())
                            
                        } else {
                            Button("Next Question") {
                                nextRound()
                            }
                            .padding()
                            .foregroundColor(.white)
                            .background(answerColorAnimation == 0 ? .gray : .indigo)
                            .clipShape(Capsule())
                            .disabled(answerColorAnimation == 0 ? true : false)
                        }
                    }
                        VStack {
                        if isShowingSmile {
                            Text("🥳")
                                .font(.system(size: 80))
                                .transition(.asymmetric(insertion: .scale, removal: .opacity))
                        }
                        }
                        .offset(x: 130, y: 230)
                        
                    }
                    .padding()
                    .navigationTitle("MultiplicationPractice")
                    .preferredColorScheme(.dark)
                } else {
                    VStack {
                        Spacer()
                        
                        VStack {
                            Text("Rates Info")
                                .font(.title)
                                .padding()
                            
                            VStack(alignment: .leading) {
                                Text("Rate Per Hour (RPH): $\(ratePerHour) - $\(rateCalculated)")
                                
                                Text("Extras:")
                                    .font(.title2)
                                
                                HStack {
                                    Text("Goal:")
                                        .padding()
                                                                        
                                    VStack(alignment: .leading) {
                                        Text("Date: $10")
                                        Text("Escort: $15")
                                        Text("Party: $20")
                                        Text("Company: $25")
                                    }
                                }
                                
                                Text("Additional Girl: $\(girlfriend)")
                                Text("Smarty: $\(smarty)")
                                Text("Speak Russian: $\(speakRussian)")
                                    
                            }
                            .font(.title3)
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(.thinMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        
                        Spacer()
                        
                        VStack {
                            Stepper("Difficulty: \(difficulty)", value: $difficulty, in: 2...9)
                            .pickerStyle(.wheel)
                                
                            Stepper("Questions: \(numberOfQuestions)", value: $numberOfQuestions, in: 5...20)
                            
                            Button("Start Game") {
                                startGame()
                            }
                            .padding()
                            .foregroundColor(.white)
                            .background(.indigo)
                            .clipShape(Capsule())
                        }
                        .padding()
                        .background(.thinMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        
                        Spacer()
                        
                        Spacer()
                    }
                    .padding()
                    .navigationTitle("Settings")
                    .preferredColorScheme(.dark)
                }
            }
        }
    }
    
    func startGame() {
        round = 0
        score = 0
        scoreScale = 1.0
        
        withAnimation {
            animateGradient.toggle()
            isGameActive.toggle()
        }
        
        nextRound()
    }
    
    func nextRound() {
        withAnimation {
            isShowingSmile = false
        }
        round += 1
        animationScale = 1.0
        disableAnswers = false
        blurAnim = false
        question = ""
        correctAnswer = 0
        answers.removeAll()
        answerStatus = "Choose the correct answer:"
        answerColorAnimation = 0
                
        condition()
    }
    
    func condition() {
        rate = ratePerHour + Int.random(in: 1...difficulty)
        let hours = Int.random(in: 1...difficulty)
        let goalPrice = goals.randomElement() ?? 10
        let numberOfGirls = Int.random(in: 1...5)
        let smartyGirls = Int.random(in: 0...numberOfGirls)
        let speakRussianGirls = Int.random(in: 0...numberOfGirls)
        
        var goal = ""
        switch goalPrice {
        case 10:
            goal = "Date"
        case 15:
            goal = "Escort"
        case 20:
            goal = "Party"
        case 25:
            goal = "Company"
        default:
            goal = ""
        }
        
        question = "RPH: $\(rate),\n\(goal) for \(hours) \(hours == 1 ? "hour" : "hours") with \(numberOfGirls) \(numberOfGirls == 1 ? "girl" : "girls").\n\(smartyGirls == 0 ? "No smarty girls" : smartyGirls == 1 ? "1 smarty girl" : "\(smartyGirls) smarty girls") and \(speakRussianGirls == 0 ? "no russians" : speakRussianGirls == 1 ? "1 russian girl" : "\(speakRussianGirls) russian girls")"
        answer = (rate * hours) + goalPrice
        answer += (numberOfGirls * girlfriend - girlfriend)
        answer += (speakRussian * speakRussianGirls)
        answer += (smarty * smartyGirls)
        correctAnswer = answer
        answers.append(answer)
        
        for _ in 0...2 {
            withAnimation {
                answer = ((ratePerHour + Int.random(in: 1...difficulty)) * Int.random(in: 1...difficulty)) + goalPrice
                answer += (numberOfGirls * girlfriend - girlfriend)
                answer += (speakRussian * speakRussianGirls)
                answer += (smarty * smartyGirls)
                answers.append(answer)
            }
        }
        answers.shuffle()
        
    }
    
    func checkAnswer(number: Int) {
        selectedAnswer = number
        animationScale = 1.0
        disableAnswers = true
        
        if number == correctAnswer {
            withAnimation {
                answerStatus = "Correct! You're Amazing!"
                answerColorAnimation = 1
                animationScale = 1.2
                isShowingSmile = true
            }
            
            score += 1
            if scoreScale < 2.0 {
                scoreScale += 0.2
            }
        } else {
            withAnimation {
                answerStatus = "Wrong, dumb ass!"
                answerColorAnimation = 2
                animationScale = 0.8
            }
            
            if score > 0 {
                score -= 1
            }
            if scoreScale > 1.0 {
                scoreScale -= 0.2
            }

            
            blurAnim = true
        }
    }
}

struct CheckRates_Previews: PreviewProvider {
    static var previews: some View {
        CheckRates()
    }
}
