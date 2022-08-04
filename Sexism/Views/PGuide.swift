//
//  PGuide.swift
//  Sexism
//
//  Created by Lem Euro on 27.07.2022.
//

import SwiftUI

struct PGuide: View {
    let models: [String: Model] = Bundle.main.decode("models.json")
    let countries: [Country] = Bundle.main.decode("countries.json")
    
    @AppStorage("showingGrid") private var showingGrid = true
    
    var body: some View {
        Group {
            if showingGrid {
                GridLayout(models: models, countries: countries)
            } else {
                ListLayout(models: models, countries: countries)
            }
        }
        .toolbar {
            Button {
                showingGrid.toggle()
            } label: {
                if showingGrid {
                    Label("Show as table", systemImage: "list.dash")
                } else {
                    Label("Show as grid", systemImage: "square.grid.2x2")
                }
            }
        }
        .navigationTitle("Prostitution Guide")
        .navigationBarTitleDisplayMode(.inline)
        .background(.darkBackground)
        .preferredColorScheme(.dark)
    }
}

struct PGuide_Previews: PreviewProvider {
    static var previews: some View {
        PGuide()
    }
}
