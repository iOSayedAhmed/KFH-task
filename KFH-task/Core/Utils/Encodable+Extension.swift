//
//  Encodable+Extension.swift
//  KFH-task
//
//  Created by iOSAYed on 13/11/2025.
//

import Foundation

extension Encodable {
    var storeData: Data? {
        let encoder = JSONEncoder()
        return try? encoder.encode(self)
    }
}
