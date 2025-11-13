//
//  RemoteDataSource.swift
//  KFH-task
//
//  Created by iOSAYed on 13/11/2025
//

import Foundation

class RemoteDataSource: RemoteDataSourceProtocol {
    private let remoteService: RestServiceProtocol

    init(remoteService: RestServiceProtocol = RestService()) {
        self.remoteService = remoteService
    }

    func getData<T>(endpoint: EndpointProtocol, completion: @escaping (Result<T, CoreError>) -> Void) where T: Decodable, T: Encodable {
        remoteService.request(endpoint: endpoint, deliverQueue: .main, completion: completion)
    }
}