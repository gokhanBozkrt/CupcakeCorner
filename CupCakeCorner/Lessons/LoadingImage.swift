//
//  LoadingImage.swift
//  CupCakeCorner
//
//  Created by Gokhan Bozkurt on 8.05.2022.
//

import SwiftUI

struct LoadingImage: View {
    var body: some View {
        AsyncImage(url: URL(string:"https://hws.dev/img/bad.png")) { phase in
            if let image = phase.image {
                image
                    .resizable()
                    .scaledToFit()
            } else if phase.error != nil {
                Text("There was an error loading the image.")
            } else {
                ProgressView()
            }
        }
        .frame(width: 200, height: 200)
    }
}

struct LoadingImage_Previews: PreviewProvider {
    static var previews: some View {
        LoadingImage()
    }
}




/*
 AsyncImage(url: URL(string:"https://hws.dev/img/logo.png")) { image in
     image
         .resizable()
         .scaledToFit()
 } placeholder: {
     ProgressView()
       
 }
 .frame(width: 200, height: 200)
 */
