//
//  ConfigurationManager.swift
//  KFH-task
//
//  Created by iOSAYed on 13/11/2025.
//

import Foundation

// MARK: - Configuration Manager
class ConfigurationManager {

    // MARK: - Singleton
    static let shared = ConfigurationManager()

    // MARK: - Properties
    private var config: [String: Any] = [:]

    // MARK: - Initialization
    private init() {
        loadConfiguration()
    }

    // MARK: - Private Methods
    private func loadConfiguration() {
        guard let path = Bundle.main.path(forResource: "Config", ofType: "plist"),
              let data = NSDictionary(contentsOfFile: path) as? [String: Any] else {
            print("⚠️ Config.plist not found, using default configuration")
            loadDefaultConfiguration()
            return
        }
        config = data
        print("Configuration loaded from Config.plist")
    }

    private func loadDefaultConfiguration() {
        config = [
            "API": [
                "BaseURL": "https://api.github.com/",
                "Timeout": 30.0,
                "Endpoints": [
                    "Repositories": "/repositories"
                ]
            ],
            "Cache": [
                "MaxAge": 300.0,
                "MaxSize": 52428800
            ],
            "App": [
                "Name": "KFH Task",
                "MinSearchCharacters": 2
            ]
        ]
    }

    // MARK: - Public Methods
    func getValue(for keyPath: String) -> Any? {
        let keys = keyPath.split(separator: ".").map(String.init)
        var current: Any? = config

        for key in keys {
            if let dict = current as? [String: Any] {
                current = dict[key]
            } else {
                return nil
            }
        }
        return current
    }

    func getString(for keyPath: String, defaultValue: String = "") -> String {
        return getValue(for: keyPath) as? String ?? defaultValue
    }

    func getDouble(for keyPath: String, defaultValue: Double = 0.0) -> Double {
        return getValue(for: keyPath) as? Double ?? defaultValue
    }

    func getInt(for keyPath: String, defaultValue: Int = 0) -> Int {
        return getValue(for: keyPath) as? Int ?? defaultValue
    }

    func getBool(for keyPath: String, defaultValue: Bool = false) -> Bool {
        return getValue(for: keyPath) as? Bool ?? defaultValue
    }
}

// MARK: - Configuration Extensions
extension ConfigurationManager {

    // MARK: - API Configuration
    var apiBaseURL: String {
        return getString(for: "API.BaseURL", defaultValue: AppConfiguration.API.baseURL)
    }

    var apiTimeout: TimeInterval {
        return getDouble(for: "API.Timeout", defaultValue: AppConfiguration.API.timeout)
    }

    var repositoriesEndpoint: String {
        return getString(for: "API.Endpoints.Repositories", defaultValue: AppConfiguration.API.Endpoints.repositories)
    }

    // MARK: - Cache Configuration
    var cacheMaxAge: TimeInterval {
        return getDouble(for: "Cache.MaxAge", defaultValue: AppConfiguration.Cache.maxAge)
    }

    var cacheMaxSize: Int {
        return getInt(for: "Cache.MaxSize", defaultValue: AppConfiguration.Cache.maxSize)
    }

    // MARK: - App Configuration
    var appName: String {
        return getString(for: "App.Name", defaultValue: AppConfiguration.App.appName)
    }

    var minSearchCharacters: Int {
        return getInt(for: "App.MinSearchCharacters", defaultValue: 2)
    }
}
