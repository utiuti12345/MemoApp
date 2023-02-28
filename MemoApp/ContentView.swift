//
//  ContentView.swift
//  MemoApp
//
//  Created by saotome on 2023/02/26.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var viewModel = MemoViewModel()
    @State private var isReachable = "NO"
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Button(action: {
                        // iPhone と Apple Watch が疎通できるか
                        // true の場合メッセージ送信可能
                        self.isReachable = self.viewModel.session.isReachable ? "YES": "NO"
                    }) {
                        Text("Check")
                    }
                    .padding(.leading, 16.0)
                    Spacer()
                    Text("isReachable")
                        .font(.headline)
                        .padding()
                    Text(self.isReachable)
                        .foregroundColor(.gray)
                        .font(.subheadline)
                        .padding()
                }
                .background(Color.init(.systemGray5))
                // 受信したメッセージを表示する
                List {
                    ForEach(self.viewModel.messages, id: \.self) { animal in
                        MessageRow(animal: animal)
                    }
                }
                .listStyle(PlainListStyle())
                Spacer()
            }
            .navigationTitle("Receiver")
        }
    }
}

struct MessageRow: View {
    let animal: String

    var body: some View {
        VStack(alignment: .leading) {
            Text(animal)
                .font(.body)
                .padding(.vertical, 4.0)
            // 受信時のタイムスタンプ
            Text(dateFomatter(date:Date()))
                .font(.footnote)
                .foregroundColor(.gray)
        }
    }
    
    private func dateFomatter(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = TimeZone(identifier: "Asia/Tokyo")

        return dateFormatter.string(from: date)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
