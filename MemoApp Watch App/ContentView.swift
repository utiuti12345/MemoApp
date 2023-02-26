//
//  ContentView.swift
//  MemoApp Watch App
//
//  Created by saotome on 2023/02/26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                HStack() {
                    Spacer()
                }
            }
            FloatingButton()
        }
    }
}

struct FloatingButton: View {
    var body: some View {
        NavigationView{
            VStack {  // --- 1
                Spacer()
                HStack { // --- 2
                    Spacer()
                    NavigationLink {RegisterView()}
                    label: {Image(systemName: "pencil")
                            .foregroundColor(.white)
                            .font(.system(size: 24)) // --- 4
                    }
                    .frame(width: 50, height: 50)
                    .background(Color.orange)
                    .cornerRadius(30.0)
                    .shadow(color: .gray, radius: 3, x: 3, y: 3)
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: -15, trailing: 2.0)) // --- 5
                    
                                
                }
            }
        }.navigationViewStyle(.stack)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
