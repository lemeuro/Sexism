//
//  ModelView.swift
//  Sexism
//
//  Created by Lem Euro on 27.07.2022.
//

import SwiftUI

struct ModelView: View {   
    let model: Model
    
    @State private var insetAmount = 0.0
    
    var body: some View {
        ScrollView {
            VStack {
                Image(model.id)
                    .resizable()
                    .scaledToFit()
                    .overlay(alignment: .bottomTrailing) {
                        Heart()
                            .fill(.purple)
                            .frame(width: 40, height: 40)
                            .saturation(0.2)
                            .blendMode(.screen)
                            .padding()
                    }
                
                Text(model.description)
                    .padding()
                
                Divider()
                
                Text("Book \(model.name) Now")
                    .font(.title.bold())
                    .padding(.bottom, 5)
                
                FunTimeView()
                
                HStack {
                    NavigationLink {
                        CheckRates()
                    } label: {
                        Text("Check Rates")
                    }
                    
                    Spacer()
                
                    NavigationLink {
                        BookingForm()
                    } label: {
                        Text("Press to Book")
                    }
                }
                .padding()
                
                Heart(insetAmount: insetAmount)
                    .strokeBorder(LinearGradient(gradient: Gradient(colors: [.indigo, .mint, .yellow]), startPoint: .top, endPoint: .bottom), lineWidth: 4)
                    .frame(width: 200, height: 200)
                    .padding()
                    .onTapGesture {
                        withAnimation {
                            insetAmount = Double.random(in: -2...2)
                        }
                    }
            }
        }
        .background(.darkBackground)
        .navigationTitle(model.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ModelView_Previews: PreviewProvider {
    static let models: [String: Model] = Bundle.main.decode("models.json")
    
    static var previews: some View {
        ModelView(model: models["marijke"]!)
            .preferredColorScheme(.dark)
    }
}
