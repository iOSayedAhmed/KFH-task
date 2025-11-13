//
//  CoreSession.swift
//  KFH-task
//
//  Created by iOSAYed on 13/11/2025
//

import Foundation

typealias DataResult = Result<Data, CoreError>

protocol CoreSessionProtocol {
    func dataTask(
        with request: URLRequest,
        completion: @escaping (DataResult) -> Void
    ) -> URLSessionDataTaskProtocol
}

class CoreSession: CoreSessionProtocol {
    private let urlSession: any URLSessionProtocol

    init(
        urlSession: any URLSessionProtocol = URLSession(configuration: .default)) {
        self.urlSession = urlSession
    }

    func dataTask(
        with request: URLRequest,
        completion: @escaping (DataResult) -> Void
    ) -> URLSessionDataTaskProtocol {

        return urlSession.dataTask(with: request) { [weak self] data, response, error in
            guard self != nil else { return }

            if let error = CoreError(data: data, response: response, error: error) {
                completion(.failure(error))
            } else if let data = data {
                completion(.success(data))
            } else {
                completion(.failure(.request(code: "\(URLError.unknown.rawValue)")))
            }
        }
    }
}