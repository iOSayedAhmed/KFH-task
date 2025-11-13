//
//  RestService.swift
//  KFH-task
//
//  Created by iOSAYed on 13/11/2025
//

import Foundation

// MARK: - RestServiceProtocol
typealias HTTPResponseCallback<T> =  (Result<T, CoreError>) -> Void

protocol RestServiceProtocol {
    func request<T: Codable>(endpoint: EndpointProtocol, deliverQueue: DispatchQueue, completion: @escaping (Result<T, CoreError>) -> Void)
}

struct RestService: RestServiceProtocol {
    private let session: CoreSessionProtocol

    init(session: CoreSessionProtocol = CoreSession()) {
        self.session = session
    }

    func request<T: Codable>(endpoint: EndpointProtocol, deliverQueue: DispatchQueue = DispatchQueue.main, completion: @escaping HTTPResponseCallback<T>) {

        guard let urlRequest = endpoint.urlRequest else {
            deliverQueue.async {
                completion(.failure(.request(code: "\(URLError.badURL)")))
            }
            return
        }

        let task = session.dataTask(with: urlRequest) { result in
            deliverQueue.async {
                let decoder = endpoint.decoder(type: T.self)
                completion(decoder.decode(result))
            }
        }

        task.resume()
    }
}