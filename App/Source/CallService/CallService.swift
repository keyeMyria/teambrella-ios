//
//  CallService.swift
//  Caller
//
//  Created by Yaroslav Pasternak on 03.08.2018.
//  Copyright © 2018 Teambrella. All rights reserved.
//

import CallKit
import Foundation

class CallService: NSObject {
    lazy var provider: CXProvider = {
        let config = CXProviderConfiguration(localizedName: "Teambrella")
        let provider = CXProvider(configuration: config)
        provider.setDelegate(self, queue: nil)
        return provider
    }()

    var connection: Connection?

    @discardableResult
    func createConnection() -> Connection {
        let connection = Assembly.connection()
        connection.offer(completion: { result in
            print("Connection result: \(result)")
        }) { error in
            print("Connection offer failed with error: \(String(describing: error))")
        }
        self.connection = connection
        return connection
    }

    func receiveACall(from name: String, userID: String) {
        let uuid = UUID(uuidString: userID) ?? UUID()
        let update = CXCallUpdate()
        update.remoteHandle = CXHandle(type: .generic, value: name)
        provider.reportNewIncomingCall(with: uuid, update: update, completion: { error in })
    }

    func makeACall(to name: String, userID: String, completion: @escaping (String?, Error?) -> Void) {
        let uuid = UUID(uuidString: userID) ?? UUID()
        print("userID: \(userID), uuid: \(uuid)")
        let controller = CXCallController()
        let transaction = CXTransaction(action: CXStartCallAction(call: uuid,
                                                                  handle: CXHandle(type: .generic, value: name)))
        controller.request(transaction, completion: { error in completion(nil, error) })
        connection?.offer(completion: { sdp in
            completion(sdp, nil)
        })
    }
}

extension CallService: CXProviderDelegate {
    func providerDidReset(_ provider: CXProvider) {
    }

    func provider(_ provider: CXProvider, perform action: CXAnswerCallAction) {
        connection?.answer(completion: { string in
            action.fulfill()
        })
    }

    func provider(_ provider: CXProvider, perform action: CXEndCallAction) {
        action.fulfill()
    }
}
