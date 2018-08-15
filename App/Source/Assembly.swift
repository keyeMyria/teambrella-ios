//
//  Assembly.swift
//  Caller
//
//  Created by Yaroslav Pasternak on 02.08.2018.
//  Copyright © 2018 Teambrella. All rights reserved.
//

import Foundation
import WebRTC

struct Assembly {
    static func connection() -> Connection {
        return Connection(stunServers: [
            RTCIceServer(urlStrings: ["stun:stun.l.google.com:19302"]),
            RTCIceServer(urlStrings: ["stun:stun1.l.google.com:19302"])
            ]
        )
    }
}
