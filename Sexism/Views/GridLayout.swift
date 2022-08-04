//
//  GridLayout.swift
//  Sexism
//
//  Created by Lem Euro on 27.07.2022.
//

import SwiftUI

struct GridLayout: View {
    let models: [String: Model]
    let countries: [Country]
    
    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach(countries) { country in
                    NavigationLink {
                        CountryView(country: country, models: models)
                    } label: {
                        VStack {
                            Image(country.image)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 100, height: 100)
                                .clipShape(Circle())
                                .overlay(
                                    Circle()
                                        .stroke(.white, lineWidth: 4)
                                )
                                .shadow(radius: 7)
                                .padding()

                            VStack {
                                Text(country.name)
                                    .font(.headline)
                                    .foregroundColor(.white)
                                
                                Text(country.formattedLegalizationDate)
                                    .font(.caption)
                                    .foregroundColor(.white.opacity(0.5))
                            }
                            .padding(.vertical)
                            .frame(maxWidth: .infinity)
                            .background(.lightBackground)
                        }
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.lightBackground)
                        )
                    }
                }
            }
            .padding([.horizontal, .bottom])
        }
    }
}

struct GridLayout_Previews: PreviewProvider {
    static var previews: some View {
        GridLayout(models: Bundle.main.decode("models.json"), countries: Bundle.main.decode("countries.json"))
            .preferredColorScheme(.dark)
    }
}
