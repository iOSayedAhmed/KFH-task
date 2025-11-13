//
//  AppConfiguration.swift
//  KFH-task
//
//  Created by iOSAYed on 13/11/2025.
//

import Foundation

// MARK: - App Configuration
struct AppConfiguration {

    // MARK: - Environment
    enum Environment {
        case development
        case staging
        case production

        var baseURL: String {
            switch self {
            case .development:
                return "https://api.github.com/"
            case .staging:
                return "https://api-staging.github.com/"
            case .production:
                return "https://api.github.com/"
            }
        }

        var isDebugMode: Bool {
            switch self {
            case .development, .staging:
                return true
            case .production:
                return false
            }
        }
    }

    // MARK: - Current Environment
    static let current: Environment = {
        #if DEBUG
        return .development
        #else
        return .production
        #endif
    }()

    // MARK: - API Configuration
    struct API {
        static let baseURL = current.baseURL
        static let timeout: TimeInterval = 30.0

        // MARK: - Endpoints
        struct Endpoints {
            static let repositories = "/repositories"
        }
    }

    // MARK: - Cache Configuration
    struct Cache {
        static let maxAge: TimeInterval = 300 // 5 minutes
        static let maxSize: Int = 50 * 1024 * 1024 // 50 MB
    }

    // MARK: - App Settings
    struct App {
        static let isDebugMode = current.isDebugMode
        static let appName = "KFH Task"
        static let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0"
    }
}
