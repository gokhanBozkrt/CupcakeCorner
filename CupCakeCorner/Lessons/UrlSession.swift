//
//  UrlSession.swift
//  CupCakeCorner
//
//  Created by Gokhan Bozkurt on 8.05.2022.
//

import SwiftUI

struct Response: Codable {
    var results: [Result]
}

struct Result: Codable {
    var trackId: Int
    var trackName: String
    var collectionName: String
}

struct UrlSession: View {
    @State private var results = [Result]()
    var body: some View {
        List(results, id: \.trackId) { item in
            VStack(alignment: .leading) {
                Text(item.trackName)
                    .font(.headline)
                Text(item.collectionName)
            }
        }.task {
           await loadData()
           
        }
    }
    // async means this method may sleep while others working
    func loadData() async {
        guard let url = URL(string: "https://itunes.apple.com/search?term=ahmet+kaya&entity=song") else {
            print("Invalid Url")
            return
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let decodedResponse = try? JSONDecoder().decode(Response.self, from: data) {
                self.results = decodedResponse.results
            }
        } catch {
            print("ınvalid data")
        }
    }
}

struct UrlSession_Previews: PreviewProvider {
    static var previews: some View {
        UrlSession()
    }
}
