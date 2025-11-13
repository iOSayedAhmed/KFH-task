//
//  RepositoriesRepoProtocol.swift
//  KFH-task
//
//  Created by iOSAYed on 13/11/2025.
//

protocol PublicRepositoriesRepoProtocol {
    func fetchPublicReposList(completion: @escaping (Result<[RepositoryModel], CoreError>) -> Void)
}
