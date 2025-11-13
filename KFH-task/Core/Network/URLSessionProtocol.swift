//
//  URLSessionProtocol.swift
//  KFH-task
//
//  Created by iOSAYed on 13/11/2025
//

import Foundation

protocol URLSessionProtocol {
    associatedtype DataTaskType: URLSessionDataTaskProtocol

    func dataTask(with request: URLRequest, completionHandler: @escaping @Sendable (Data?, URLResponse?, Error?) -> Void) -> DataTaskType
}

extension URLSession: URLSessionProtocol {}