//
//  PublicRepositoryUseCase.swift
//  KFH-task
//
//  Created by iOSAYed on 13/11/2025.
//

// MARK: PublicRepositoryUseCaseDataStore
protocol PublicRepositoryUseCaseDataStore: AnyObject {
    var repositories: [RepositoryModel] { get }
}

// MARK: PublicRepositoryUseCaseProtocol
protocol PublicRepositoryUseCaseProtocol: AnyObject {
    func fetchPublicReposList(completion: @escaping (Result<[RepositoryModel], CoreError>) -> Void)
    func searchPublicReposList(query: String,
                               completion: @escaping ([RepositoryModel]) -> Void)
}

// MARK: PublicRepositoryUseCase
class PublicRepositoryUseCase: PublicRepositoryUseCaseDataStore {

    var repositories: [RepositoryModel] = []
    private var minCharacheterForSearch: Int {
        return ConfigurationManager.shared.minSearchCharacters
    }

    private let repo: PublicRepositoriesRepoProtocol

    init(repo: PublicRepositoriesRepoProtocol) {
        self.repo = repo
    }
}

extension PublicRepositoryUseCase: PublicRepositoryUseCaseProtocol {
    func fetchPublicReposList(completion: @escaping (Result<[RepositoryModel], CoreError>) -> Void) {
        repo.fetchPublicReposList { [weak self] result in
            switch result {
            case .success(let data):
                self?.repositories = data
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func searchPublicReposList(query: String,
                                      completion: @escaping ([RepositoryModel]) -> Void) {
        guard query.count > minCharacheterForSearch else {
            completion(self.repositories)
            return
        }
        let result = self.repositories.filter { $0.name.lowercased().contains(query.lowercased()) }
        completion(result)
    }
}
