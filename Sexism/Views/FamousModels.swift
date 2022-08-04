//
//  FamousModels.swift
//  Sexism
//
//  Created by Lem Euro on 27.07.2022.
//

import SwiftUI

struct FamousModels: View {
    let models: [CountryView.FemaleModel]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(models, id: \.id) { femaleModel in
                    NavigationLink {
                        ModelView(model: femaleModel.model)
                    } label: {
                        HStack {
                            Image(femaleModel.model.id)
                                .resizable()
                                .scaledToFill()
                                .clipped()
                                .frame(width: 72, height: 104)
                                .clipShape(Capsule())
                                .overlay(
                                    Capsule()
                                        .strokeBorder(.white, lineWidth: 1)
                                )
                            
                            VStack(alignment: .leading) {
                                Text(femaleModel.model.name)
                                    .foregroundColor(.white)
                                    .font(.headline)
                                
                                Text(femaleModel.role)
                                    .foregroundColor(.secondary)
                            }
                        }
                        .padding(.horizontal)
                    }
                }
            }
        }
    }
}

struct FamousModels_Previews: PreviewProvider {
    static var previews: some View {
        FamousModels(models: [])
    }
}
