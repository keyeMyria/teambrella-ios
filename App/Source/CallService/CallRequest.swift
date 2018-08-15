//
//  CallRequest.swift
//  Caller
//
//  Created by Yaroslav Pasternak on 02.08.2018.
//  Copyright © 2018 Teambrella. All rights reserved.
//

import Foundation

struct CallRequest: Codable {
    let from: String
    let to: String
    /// Interactive Connectivity Establishment
    let ice: String
}
