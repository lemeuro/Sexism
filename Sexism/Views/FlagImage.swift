//
//  FlagImage.swift
//  Sexism
//
//  Created by Lem Euro on 30.07.2022.
//

import SwiftUI

struct FlagImage: View {
    let name: String
    
    var body: some View {
        Image(name)
            .renderingMode(.original)
            .resizable()
            .frame(width: 180, height: 80)
            .scaledToFill()
            .clipShape(Capsule())
            .shadow(radius: 5)
    }
}

struct FlagImage_Previews: PreviewProvider {
    static var previews: some View {
        FlagImage(name: "fr")
    }
}

