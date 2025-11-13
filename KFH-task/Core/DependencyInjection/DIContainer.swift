//
//  DIContainer.swift
//  KFH-task
//
//  Created by iOSAYed on 13/11/2025.
//

import Foundation

// MARK: - Dependency Injection Container
final class DIContainer: ObservableObject {

    // MARK: - Shared Instance
    static let shared = DIContainer()

    // MARK: - Core Dependencies
    private let cacheRepo: any CacheRepoProtocol
    private let remoteDataSource: RemoteDataSourceProtocol
    private let localDataSource: LocalDataSourceProtocol

    // MARK: - Repository
    private let publicRepositoryRepo: PublicRepositoriesRepoProtocol

    // MARK: - Use Cases
    let publicRepositoryUseCase: PublicRepositoryUseCaseProtocol

    // MARK: - Image Cache
    let imageCache: ImageCache

    // MARK: - Initialization
    private init() {
        // Initialize core components
        self.imageCache = ImageCache()
        self.cacheRepo = CacheRepo()
        self.remoteDataSource = RemoteDataSource()
        self.localDataSource = LocalDataSource()

        // Initialize repository
        self.publicRepositoryRepo = PublicRepositoryRepo()

        // Initialize use case
        self.publicRepositoryUseCase = PublicRepositoryUseCase(
            repo: publicRepositoryRepo
        )
    }

    // MARK: - Factory Methods
    func makeRepositoryListViewModel() -> RepositoryListViewModel {
        return RepositoryListViewModel(useCase: publicRepositoryUseCase)
    }
}
