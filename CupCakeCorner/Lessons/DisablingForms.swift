//
//  DisablingForms.swift
//  CupCakeCorner
//
//  Created by Gokhan Bozkurt on 8.05.2022.
//

import SwiftUI

struct DisablingForms: View {
    @State private var userName = ""
    @State private var email = ""
    
    
    var body: some View {
        Form {
            Section {
                TextField("Username", text: $userName)
                TextField("Email", text: $email)
            }
            Section {
                Button("Create Account") {
                    print("Creating account...")
                }
            }.disabled(disableForm)
            //.disabled(userName.isEmpty || email.isEmpty)
        }
    }
    
    var disableForm: Bool {
        userName.count < 5 || email.count < 5
    }
}

struct DisablingForms_Previews: PreviewProvider {
    static var previews: some View {
        DisablingForms()
    }
}
