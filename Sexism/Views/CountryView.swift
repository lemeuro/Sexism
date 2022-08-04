//
//  CountryView.swift
//  Sexism
//
//  Created by Lem Euro on 26.07.2022.
//

import SwiftUI

struct CountryView: View {
    struct FemaleModel {
        let id = UUID()
        let role: String
        let model: Model
    }
    
    let country: Country
    let models: [FemaleModel]
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack {
//                    Image(country.image)
//                        .resizable()
//                        .scaledToFit()
//                        .frame(maxWidth: geometry.size.width * 0.6)
//                        .padding(.vertical)
                    
                    GuessTheFlag(country: country)
                    
                    if let date = country.legalizationDate {
                        Label("Date of Legalization: \(date.formatted(date: .abbreviated, time: .omitted))", systemImage: "calendar")
                    }
                                        
                    VStack(alignment: .leading) {
                        if let sexPlace = country.place {
                            CustomDivider()
                            
                            MapView(sexPlace: sexPlace)
                        }
                        
                        CustomDivider()
                        
                        Text("Country Highlights")
                            .font(.title.bold())
                            .padding(.bottom, 5)
                        
                        Text(country.prostitutionDescription)
                        
                        CustomDivider()
                                                
                        Text("Famous Models")
                            .font(.title.bold())
                            .padding(.bottom, 5)
                    }
                    .padding(.horizontal)
            
                    FamousModels(models: models)
                    
                    VStack(alignment: .leading) {
                        CustomDivider()
                        
                        Text("Used Units")
                            .font(.title.bold())
                            .padding(.bottom, 5)
                        
                        ForEach(0..<3) {
                            Text("\(UnitConverter.conversions[$0]): \(country.units[$0].unit)")
                        }
                    }
                    .padding(.horizontal)
                        
                    UnitConverter()
                }
                .padding(.bottom)
            }
        }
        .navigationTitle(country.name)
        .navigationBarTitleDisplayMode(.inline)
        .background(.darkBackground)
    }
    
    init(country: Country, models: [String: Model]) {
        self.country = country
        
        self.models = country.models.map { girl in
            if let model = models[girl.name] {
                return FemaleModel(role: girl.role, model: model)
            } else {
                fatalError("Missing \(girl.name)")
            }
        }
    }
}

struct CountryView_Previews: PreviewProvider {
    static let countries: [Country] = Bundle.main.decode("countries.json")
    static let models: [String: Model] = Bundle.main.decode("models.json")
    
    static var previews: some View {
        CountryView(country: countries[0], models: models)
            .preferredColorScheme(.dark)
    }
}
