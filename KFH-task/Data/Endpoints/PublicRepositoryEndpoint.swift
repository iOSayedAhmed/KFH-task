//
//  PublicRepositoryEndpoint.swift
//  KFH-task
//
//  Created by iOSAYed on 13/11/2025.
//

enum PublicRepositoryEndpoint {
    case getPublicRepository
}

extension PublicRepositoryEndpoint: EndpointProtocol {

    var baseURL: String {
        // Option 1: Use Configuration Manager (reads from Config.plist)
        return ConfigurationManager.shared.apiBaseURL

        // Option 2: Use static configuration (uncomment if you prefer this)
        // return AppConfiguration.API.baseURL
    }

    var path: String {
        switch self {
        case .getPublicRepository:
            // Option 1: Use Configuration Manager (reads from Config.plist)
            return ConfigurationManager.shared.repositoriesEndpoint

            // Option 2: Use static configuration (uncomment if you prefer this)
            // return AppConfiguration.API.Endpoints.repositories
        }
    }
}
