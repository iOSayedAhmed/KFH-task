//
//  CacheRepoProtocol.swift
//  KFH-task
//
//  Created by iOSAYed on 13/11/2025
//

protocol CacheRepoProtocol {
    associatedtype Local
    associatedtype Remote

    func getData<T: Codable>(endpoint: EndpointProtocol, cachePolicy: CachePolicy, completion:  @escaping (Result<T, CoreError>) -> Void)
    func removeCachedData(with endpoint: EndpointProtocol, completion: @escaping () -> Void)
}