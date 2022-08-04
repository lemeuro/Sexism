//
//  UnitConverter.swift
//  Sexism
//
//  Created by Lem Euro on 27.07.2022.
//

import SwiftUI

struct UnitConverter: View {
    @State private var input = 100.0
    @State private var selectedUnits = 0
    @State private var inputUnit: Dimension = UnitLength.meters
    @State private var outputUnit: Dimension = UnitLength.kilometers
    @FocusState private var inputIsFocused: Bool
    
    static let conversions = ["Distance", "Mass", "Temperature"]
    
    let unitTypes = [
        [UnitLength.feet, UnitLength.kilometers, UnitLength.meters, UnitLength.miles, UnitLength.yards],
        [UnitMass.grams, UnitMass.kilograms, UnitMass.ounces, UnitMass.pounds],
        [UnitTemperature.fahrenheit, UnitTemperature.celsius, UnitTemperature.kelvin]
//        [UnitDuration.hours, UnitDuration.minutes, UnitDuration.seconds]
    ]
    
    let formatter: MeasurementFormatter
    
    var result: String {
        let inputMeasurement = Measurement(value: input, unit: inputUnit)
        let outputMeasurement = inputMeasurement.converted(to: outputUnit)
        return formatter.string(from: outputMeasurement)
    }
    
    var body: some View {
        Form {
            Group {
                Section {
                    TextField("Amount", value: $input, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($inputIsFocused)
                } header: {
                    Text("Amount to convert")
                }
                
                Picker("Conversion", selection: $selectedUnits) {
                    ForEach(0..<Self.conversions.count, id: \.self) {
                        Text(Self.conversions[$0])
                            .foregroundColor(.primary)
                    }
                }
                
                Picker("Convert from", selection: $inputUnit) {
                    ForEach(unitTypes[selectedUnits], id: \.self) {
                        Text(formatter.string(from: $0).capitalized)
                    }
                }
                
                Picker("Convert to", selection: $outputUnit) {
                    ForEach(unitTypes[selectedUnits], id: \.self) {
                        Text(formatter.string(from: $0).capitalized)
                    }
                }
                
                Section {
                    Text(result)
                } header: {
                    Text("Result")
                }
            }
            .listRowBackground(Color.lightBackground)
        }
        .frame(height: 380)
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                Spacer()

                Button("Done") {
                    inputIsFocused = false
                }
            }
        }
        .onChange(of: selectedUnits) { newSelection in
            let units = unitTypes[newSelection]
            inputUnit = units[0]
            outputUnit = units[1]
        }
    }
    
    init() {
        formatter = MeasurementFormatter()
        formatter.unitOptions = .providedUnit
        formatter.unitStyle = .long
        UITableView.appearance().backgroundColor = .clear
    }
}

struct UnitConverter_Previews: PreviewProvider {
    static var previews: some View {
        UnitConverter()
            .preferredColorScheme(.dark)
    }
}
