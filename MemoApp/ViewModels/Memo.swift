//
//  Memo.swift
//  MemoApp
//
//  Created by saotome on 2023/02/28.
//

import Foundation
import SwiftUI
import WatchConnectivity

final class MemoViewModel: NSObject,ObservableObject {
    @Published var messages: [String] = []

    var session: WCSession

    init(session: WCSession = .default) {
        self.session = session
        super.init()
        self.session.delegate = self
        session.activate()
    }
}

extension MemoViewModel: WCSessionDelegate {
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        if let error = error {
            print(error.localizedDescription)
        } else {
            print("111111.")
            print("The session has completed activation.")
        }
    }
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        // メインスレッドで処理
        DispatchQueue.main.async {
            print("received.")
            let receivedId = message["id"] as? UUID ?? UUID()
            let receivedContent = message["content"] as? String ?? ""
            let receivedCreatedAt = message["createdAt"] as? Date ?? Date()
            let receivedUpdatedAt = message["updatedAt"] as? Date ?? Date()
            print(receivedId)
            print(receivedContent)
            print(receivedCreatedAt)
            print(receivedUpdatedAt)
            // 受信したメッセージを配列に格納し配列を更新
            self.messages.append(receivedContent)
        }
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
    }
    func sessionDidDeactivate(_ session: WCSession) {
    }
}
