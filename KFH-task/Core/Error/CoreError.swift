//
//  CoreError.swift
//  KFH-task
//
//  Created by iOSAYed on 13/11/2025.
//

import Foundation

// MARK: - CoreError
enum CoreError: Error {
    case response(code: String, message: String? = nil)
    case request(code: String, message: String? = nil)
    case network(code: String, message: String? = nil)
    case business(code: String, message: String? = nil)

    var code: String {
        switch self {
            case let .response(code, _), let .request(code, _), let .network(code, _), let .business(code, _):
            return code
        }
    }

    var message: String? {
        switch self {
            case let .response(_, message), let .request(_, message), let .network(_, message),  let .business(_, message):
            return message
        }
    }
}
