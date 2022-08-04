//
//  HeartView.swift
//  Sexism
//
//  Created by Lem Euro on 28.07.2022.
//

import SwiftUI

struct Heart: InsettableShape {
    var translation = 0.0
    var scale = 1.0
    var insetAmount = 0.0
    
    var animatableData: Double {
        get { insetAmount }
        set { insetAmount = newValue }
    }
    
    func path(in rect: CGRect) -> Path {
        let sideOne = rect.width * 0.4
        let sideTwo = rect.height * 0.3
        let arcRadius = sqrt(sideOne*sideOne + sideTwo*sideTwo)/2 + insetAmount
        
        var heartOne = Path { path in
            path.addArc(center: CGPoint(x: rect.width * 0.3, y: rect.height * 0.35), radius: arcRadius, startAngle: .degrees(135), endAngle: .degrees(315), clockwise: false)
            
            path.addLine(to: CGPoint(x: rect.width / 2, y: rect.height * 0.2))
            
            path.addArc(center: CGPoint(x: rect.width * 0.7, y: rect.height * 0.35), radius: arcRadius, startAngle: .degrees(225), endAngle: .degrees(45), clockwise: false)
            
            path.addLine(to: CGPoint(x: rect.width * 0.5, y: rect.height * 0.95 + insetAmount))
            
            path.closeSubpath()
        }
        
        let heartTwo = Path { path in
            path.addArc(center: CGPoint(x: rect.width * 0.3, y: rect.height * 0.35), radius: arcRadius, startAngle: .degrees(135), endAngle: .degrees(315), clockwise: false)
            
            path.addLine(to: CGPoint(x: rect.width / 2, y: rect.height * 0.2))
            
            path.addArc(center: CGPoint(x: rect.width * 0.7, y: rect.height * 0.35), radius: arcRadius, startAngle: .degrees(225), endAngle: .degrees(45), clockwise: false)
            
            path.addLine(to: CGPoint(x: rect.width * 0.5, y: rect.height * 0.95 + insetAmount))
            
            path.closeSubpath()
            
        }
        
        let rotation = CGAffineTransform(rotationAngle: -0.01)
        let scale = rotation.concatenating(CGAffineTransform(scaleX: scale, y: scale))
        let position = scale.concatenating(CGAffineTransform(translationX: translation, y: translation))
        let rotatedPetal = heartTwo.applying(position)
        
        heartOne.addPath(rotatedPetal)

        return heartOne
    }
    
    func inset(by amount: CGFloat) -> some InsettableShape {
        var arc = self
        arc.insetAmount += amount
        return arc
    }
}

struct HeartView: View {
    @State private var translation = 0.0
    @State private var scale = 1.0
    
    @State private var color = Color(.red)
    @State private var red = 0.9
    @State private var green = 0.0
    @State private var blue = 0.0
    
    var body: some View {
        VStack {
            Heart(translation: translation, scale: scale)
                .fill(color, style: FillStyle(eoFill: true))
                .frame(width: 200, height: 200)
                .padding()
                .onTapGesture {
                    withAnimation {
                        red = Double.random(in: 0...1.0)
                        green = Double.random(in: 0...1.0)
                        blue = Double.random(in: 0...1.0)
                        color = Color(red: red, green: green, blue: blue)
                    }
                }

            Text("Amount of Love")
            
            Slider(value: $scale, in: 0...1)
                .padding([.horizontal, .bottom])
            
            Text("Rapport")
            
            Slider(value: $translation, in: 0...100)
                .padding([.horizontal, .bottom])
            
        }
    }
}

struct HeartView_Previews: PreviewProvider {
    static var previews: some View {
        HeartView()
            .preferredColorScheme(.dark)
    }
}
