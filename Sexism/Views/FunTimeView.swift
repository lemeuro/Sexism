//
//  FunTimeView.swift
//  Sexism
//
//  Created by Lem Euro on 30.07.2022.
//

import CoreML
import SwiftUI

struct FunTimeView: View {
    @State private var toWork = defaultToWorkTime
    @State private var funTime = 2.0
    @State private var girls = 1
        
    static var defaultToWorkTime: Date {
        var components = DateComponents()
        components.hour = 9
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date.now
    }
    
    var funTimeResults: String {
        do {
            let config = MLModelConfiguration()
            let model = try FunTimeCalculator(configuration: config)
            
            let components = Calendar.current.dateComponents([.hour, .minute], from: toWork)
            let hour = (components.hour ?? 0) * 60 * 60
            let minute = (components.minute ?? 0) * 60
            
            let prediction = try model.prediction(whenToWork: Double(hour + minute), funTime: funTime, numberOfGirls: Double(girls))
            
            let sleepTime = toWork - prediction.bestTimeForOrder - 8*60*60
            return "Ideal time to order is " + sleepTime.formatted(date: .omitted, time: .shortened)
        } catch {
            return "There was an error"
        }
    }
    
    var body: some View {
            Form {
                Group {
                    Section {
                        DatePicker("Please enter a time", selection: $toWork, displayedComponents: .hourAndMinute)
                            .labelsHidden()
                    } header: {
                        Text("When do you need go to work?")
                    }
                    
                    Section {
                        Stepper("\(funTime.formatted()) hours", value: $funTime, in: 1...12, step: 0.50)
                    } header: {
                        Text("Desired amount of \"fun\" time")
                    }
                    
                    Section {
                        Picker("Number of girls", selection: $girls) {
                            ForEach(1..<6, id: \.self) {
                                Text(String($0))
                            }
                        }
                    } header: {
                        Text("Do you want some girlfriends?")
                    }
                    
                    Text(funTimeResults)
                        .font(.title3)
                }
                .listRowBackground(Color.lightBackground)
            }
            .frame(height: 400)
    }
}

struct FunTimeView_Previews: PreviewProvider {
    static var previews: some View {
        FunTimeView()
    }
}
