//
//  ContentView.swift
//  Sexism
//
//  Created by Lem Euro on 25.07.2022.
//

import SwiftUI

struct ContentView: View {   
    var body: some View {
        NavigationView {
            ScrollView {
                Text("This app was created only to demonstrate my dev skills. All data is just sample data, have fun.")
                
                NavigationLink {
                    GirlNames()
                } label: {
                    Text("Play Girl Names")
                        .padding()
                }
                
                NavigationLink {
                    PGuide()
                } label: {
                    Text("Show Prostitution Guide")
                        .padding()
                }
                
                HeartView()
                    .padding()
            }
            .navigationTitle("Sexism")
            .preferredColorScheme(.dark)
            .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
