//
//  URLSessionDataTaskProtocol.swift
//  KFH-task
//
//  Created by iOSAYed on 13/11/2025
//

import Foundation

protocol URLSessionDataTaskProtocol {
    func resume()
}

extension URLSessionDataTask: URLSessionDataTaskProtocol {}