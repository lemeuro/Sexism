//
//  ListLayout.swift
//  Sexism
//
//  Created by Lem Euro on 27.07.2022.
//

import SwiftUI

struct ListLayout: View {
    let models: [String: Model]
    let countries: [Country]
    
    var body: some View {
        List(countries) { country in
            NavigationLink {
                CountryView(country: country, models: models)
            } label: {
                HStack {
                    Image(country.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 40)
                        .padding()
                    
                    VStack(alignment: .leading) {
                        Text(country.name)
                            .font(.headline)
                        
                        Text(country.formattedLegalizationDate)
                    }
                    
                    Spacer()
                    
                    if let sexPlace = country.place {
                        sexPlace.image
                            .resizable()
                            .scaledToFill()
                            .frame(width: 40, height: 30)
                            .padding()
                    }
                }
            }
            .listRowBackground(Color.darkBackground)
        }
        .listStyle(.plain)
    }
}

struct ListLayout_Previews: PreviewProvider {
    static var previews: some View {
        ListLayout(models: Bundle.main.decode("models.json"), countries: Bundle.main.decode("countries.json"))
            .preferredColorScheme(.dark)
    }
}
