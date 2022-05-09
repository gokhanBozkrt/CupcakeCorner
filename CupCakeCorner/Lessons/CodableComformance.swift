//
//  Codable.swift
//  CupCakeCorner
//
//  Created by Gokhan Bozkurt on 8.05.2022.
//

import SwiftUI
import Foundation

class User: Codable,ObservableObject {
    enum CodingKeys: CodingKey {
        case name
    }
    @Published var name = "Taylor Swift"
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
    }
}



struct CodableComformance: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct CodableComformance_Previews: PreviewProvider {
    static var previews: some View {
        CodableComformance()
    }
}
