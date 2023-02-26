//
//  RegisterView.swift
//  MemoApp Watch App
//
//  Created by saotome on 2023/02/26.
//

import SwiftUI

struct RegisterView: View {
    @State private var name = ""
    
    var body: some View {
        NavigationStack{
            VStack(spacing: 30) {
                Text("Hello, \(name)")
                TextField("Enter your name", text: $name)
            }
        }
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
