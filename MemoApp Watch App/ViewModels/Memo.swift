//
//  Memo.swift
//  MemoApp Watch App
//
//  Created by saotome on 2023/02/28.
//

import Foundation
import WatchConnectivity

final class MemoViewModel: NSObject {

    var session: WCSession

    init(session: WCSession  = .default) {
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
            print("The session has completed activation.")
        }
    }
}
