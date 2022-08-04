//
//  Country.swift
//  Sexism
//
//  Created by Lem Euro on 26.07.2022.
//

import CoreLocation
import Foundation
import SwiftUI

@dynamicMemberLookup
struct Country: Codable, Identifiable {
    struct ModelRole: Codable {
        let name: String
        let role: String
    }
    
    struct CountryUnit: Codable {
        let name: String
        let unit: String
    }
    
    struct SexPlace: Codable {
        let name: String
        
        private var imageName: String
        var image: Image {
            Image(imageName)
        }
        
        private var coordinates: Coordinates
        var locationCoordinate: CLLocationCoordinate2D {
            CLLocationCoordinate2D(
                latitude: coordinates.latitude,
                longitude: coordinates.longitude
            )
        }
        
        struct Coordinates: Codable {
            var latitude: Double
            var longitude: Double
        }
    }
    
    let id: String
    let name: String
    let status: String
    var models: [ModelRole]
    let legalizationDate: Date?
    let prostitutionDescription: String
    let place: SexPlace?
    
    var image: String {
        "\(id)"
    }
    
    var units: [CountryUnit]
    
    var formattedLegalizationDate: String {
        legalizationDate?.formatted(date: .abbreviated, time: .omitted) ?? "N/A"
    }
    
    subscript<T>(dynamicMember keyPath: KeyPath<[ModelRole], T>) -> T {
        models[keyPath: keyPath]
    }

    subscript<T>(dynamicMember keyPath: WritableKeyPath<[ModelRole], T>) -> T {
        get {
            models[keyPath: keyPath]
        }

        set {
            models[keyPath: keyPath] = newValue
        }
    }
}
