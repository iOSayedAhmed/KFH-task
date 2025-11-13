//
//  RepositoryListRouter.swift
//  KFH-task
//
//  Created by iOSAYed on 13/11/2025
//

import Foundation

class RepositoryListRouter {
    static func assemple() -> RepositoryListView? {
        let repo = PublicRepositoryRepo()
        let useCase = PublicRepositoryUseCase(repo: repo)
        let viewModel = RepositoryListViewModel(useCase: useCase)
        let view = RepositoryListView(viewModel: viewModel)
        return  view
    }
}