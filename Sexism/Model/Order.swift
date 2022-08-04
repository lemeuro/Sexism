//
//  Order.swift
//  Sexism
//
//  Created by Lem Euro on 02.08.2022.
//

import SwiftUI

class Order: ObservableObject, Codable {
    enum CodingKeys: CodingKey {
        case goal, numberOfGirls, intelligence, speakRussian, name, address
    }
    
    static let goal = ["Date", "Escort", "Party", "Company"]
    
    @Published var goal = 0
    @Published var numberOfGirls = 2
    
    @Published var specialRequestEnabled = false {
        didSet {
            if specialRequestEnabled == false {
                intelligence = false
                speakRussian = false
            }
        }
    }
    
    @Published var intelligence = false
    @Published var speakRussian = false
    
    @Published var name = ""
    @Published var address = ""
    
    var hasValidMeetingPoint: Bool {
        if address.isReallyEmpty {
            return false
        }
        
        return true
    }
    
    var cost: Double {
        // $20 per strip
        var cost = Double(numberOfGirls) * 20
        
        // complex goals cost more
        cost += (Double(goal) / 2)
        
        // $10 for smart girl
        if intelligence {
            cost += Double(numberOfGirls)
        }
        
        // $5 if you want to fuck russians
        if speakRussian {
            cost += Double(numberOfGirls) / 2
        }
        
        return cost
    }
    
    init() { }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(goal, forKey: .goal)
        try container.encode(numberOfGirls, forKey: .numberOfGirls)
        
        try container.encode(intelligence, forKey: .intelligence)
        try container.encode(speakRussian, forKey: .speakRussian)
        
        try container.encode(name, forKey: .name)
        try container.encode(address, forKey: .address)
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        goal = try container.decode(Int.self, forKey: .goal)
        numberOfGirls = try container.decode(Int.self, forKey: .numberOfGirls)
        
        intelligence = try container.decode(Bool.self, forKey: .intelligence)
        speakRussian = try container.decode(Bool.self, forKey: .speakRussian)
        
        name = try container.decode(String.self, forKey: .name)
        address = try container.decode(String.self, forKey: .address)
    }
}
