//
//  BookingForm.swift
//  Sexism
//
//  Created by Lem Euro on 02.08.2022.
//

import SwiftUI

struct BookingForm: View {
    @StateObject var order = Order()
    
    var body: some View {
        Form {
            Section {
                Picker("Select your goal", selection: $order.goal) {
                    ForEach(Order.goal.indices, id: \.self) {
                        Text(Order.goal[$0])
                    }
                }
                
                Stepper("Number of girls: \(order.numberOfGirls)", value: $order.numberOfGirls, in: 1...5)
            }
            
            Section {
                Toggle("Any special requests?", isOn: $order.specialRequestEnabled.animation())
            }
            
            if order.specialRequestEnabled {
                Section {
                    Toggle("Intelligence", isOn: $order.intelligence)
                } header: {
                    Text("Do you want smart?")
                }
                
                Section("Do you want to fuck a Russian?") {
                    Toggle("Russian Language", isOn: $order.speakRussian)
                }
            }
            
            Section {
                TextField("Meeting Point", text: $order.address)
            }
            
            Section {
                NavigationLink {
                    CheckoutView(order: order)
                } label: {
                    Text("Check out")
                }
            }
            .disabled(order.hasValidMeetingPoint == false)
        }
        .navigationTitle("Book Girl")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct BookingForm_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            BookingForm()
                .preferredColorScheme(.dark)
        }
    }
}
