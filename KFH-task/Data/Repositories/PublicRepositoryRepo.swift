//
//  PublicRepositoryRepo.swift
//  KFH-task
//
//  Created by iOSAYed on 13/11/2025.
//

class PublicRepositoryRepo: CacheRepo { }

extension PublicRepositoryRepo: PublicRepositoriesRepoProtocol {
    func fetchPublicReposList(completion: @escaping (Result<[RepositoryModel], CoreError>) -> Void) {
        let endpoint = PublicRepositoryEndpoint.getPublicRepository
        self.getData(endpoint: endpoint, cachePolicy: .remoteFirst) { result in
            completion(result)
        }
    }
}
