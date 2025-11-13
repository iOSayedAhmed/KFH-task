//
//  RepositoryListViewModel.swift
//  KFH-task
//
//  Created by iOSAYed on 13/11/2025
//

import Combine
import Foundation

// MARK: - RepositoryListViewModelProtocol
protocol RepositoryListViewModelProtocol {
    func fetchPublicReposList()
    func search(query: String)
}

// MARK: - RepositoryListViewModel
class RepositoryListViewModel: ObservableObject {

    @Published private(set) var title = "Repositories"
    @Published private(set) var repos: [PublicRepositoryUI] = []
    @Published var showError = false
    var errorMessage: String?

    private var useCase: PublicRepositoryUseCaseProtocol

    init(useCase: PublicRepositoryUseCaseProtocol) {
        self.useCase = useCase
    }
}

extension RepositoryListViewModel: RepositoryListViewModelProtocol {
    func fetchPublicReposList() {
        useCase.fetchPublicReposList { [weak self] result in
            switch result {
            case let .success(data):
                self?.didLoadPublicRepositories(data)
            case let .failure(error):
                self?.didFailToLoadPublicRepositories(error)
            }
        }
    }

    func search(query: String) {
        useCase.searchPublicReposList(query: query) { [weak self] data in
            self?.didLoadPublicRepositories(data)
        }
    }
}

// MARK: - RepositoryListViewModelHelpers
extension RepositoryListViewModel {
    func didLoadPublicRepositories(_ repositories: [RepositoryModel]) {
        self.repos = repositoriesUI(repositories)
    }

    func didFailToLoadPublicRepositories(_ error: CoreError) {
        errorMessage = "\(error)"
        showError = true
    }
}

extension RepositoryListViewModel {
    func repositoriesUI(_ repositories: [RepositoryModel]) -> [PublicRepositoryUI] {
        return repositories.map {
            return PublicRepositoryUI(id: $0.id,
                                      title: $0.name,
                                      ownerName: $0.owner.login,
                                      description: $0.description,
                                      ownerAvatarURL: $0.owner.avatarURL,
                                      repository: $0)
        }
    }
}
