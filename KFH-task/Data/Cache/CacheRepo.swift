//
//  CacheRepo.swift
//  KFH-task
//
//  Created by iOSAYed on 13/11/2025
//

open class CacheRepo: CacheRepoProtocol {
    typealias Local = LocalDataSourceProtocol
    typealias Remote = RemoteDataSourceProtocol

    private let local: Local
    private let remote: Remote

    init(local: Local = LocalDataSource(), remote: Remote = RemoteDataSource()) {
        self.local = local
        self.remote = remote
    }

    final func getData<T: Codable>(endpoint: EndpointProtocol, cachePolicy: CachePolicy = .never, completion: @escaping (Result<T, CoreError>) -> Void) {
        switch cachePolicy {
        case .never:
            remote.getData(endpoint: endpoint, completion: completion)
        case .always:
            getCachedFirst(endpoint: endpoint, completion: completion)
        case .remoteFirst:
            fetchRemoteFirst(endpoint: endpoint, completion: completion)
        }
    }

    private func getCachedFirst<T: Codable>(endpoint: EndpointProtocol, completion: @escaping (Result<T, CoreError>) -> Void) {
        local.getData(endpoint: endpoint) {[weak self] (result: Result<T, CoreError>)  in
            switch result {
            case let .success(data):
                completion(.success(data))
            case .failure:
                self?.fetchData(endpoint: endpoint, completion: completion)
            }
        }
    }

    private func fetchData<T: Codable>(endpoint: EndpointProtocol, completion: @escaping (Result<T, CoreError>) -> Void) {
        remote.getData(endpoint: endpoint) {[weak self] (result: Result<T, CoreError>)  in
            switch result {
            case let .success(data):
                self?.local.saveData(endpoint: endpoint, data: data, completion: completion)
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }

    private func fetchRemoteFirst<T: Codable>(endpoint: EndpointProtocol, completion: @escaping (Result<T, CoreError>) -> Void) {
        remote.getData(endpoint: endpoint) {[weak self] (result: Result<T, CoreError>)  in
            switch result {
            case let .success(data):
                self?.local.saveData(endpoint: endpoint, data: data, completion: completion)
            case .failure:
                self?.local.getData(endpoint: endpoint, completion: completion)
            }
        }
    }

    func removeCachedData(with endpoint: EndpointProtocol, completion: @escaping () -> Void) {
        local.removeData(with: endpoint, completion: completion)
    }
}