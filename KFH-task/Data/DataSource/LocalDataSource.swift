//
//  LocalDataSource.swift
//  KFH-task
//
//  Created by iOSAYed on 13/11/2025
//

import Foundation

class LocalDataSource: LocalDataSourceProtocol {

    private let userDefaults = UserDefaults.standard

    init() { }

    func getData<T: Codable>(endpoint: EndpointProtocol, completion:  @escaping (Result<T, CoreError>) -> Void) {
        guard let savedData = userDefaults.data(forKey: endpoint.cachingKey),
                let data: T = savedData.decoded()
        else {
            completion(.failure(.response(code: "\(URLError.resourceUnavailable)")))
            return
        }

        completion(.success(data))
    }

    func saveData<T: Codable>(endpoint: EndpointProtocol, data: T, completion: @escaping (Result<T, CoreError>) -> Void) {
        userDefaults.setValue(data.storeData, forKey: endpoint.cachingKey)
        completion(.success(data))
    }

    func removeData(with endpoint: EndpointProtocol, completion: @escaping () -> Void) {
        userDefaults.removeObject(forKey: endpoint.cachingKey)
        completion()
    }
}