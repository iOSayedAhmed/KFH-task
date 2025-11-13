//
//  HTTPMethod.swift
//  KFH-task
//
//  Created by iOSAYed on 13/11/2025.
//

enum HttpMethod: String {
    case get
    case head
    case post
    case put
    case delete
    case connect
    case options
    case trace
    case patch

    var value: String {
        return rawValue.uppercased()
    }
}
