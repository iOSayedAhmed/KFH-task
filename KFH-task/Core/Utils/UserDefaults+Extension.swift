//
//  UserDefaults+Extension.swift
//  KFH-task
//
//  Created by iOSAYed on 13/11/2025.
//  KFH-task

import Foundation

extension UserDefaults {

    // MARK: - Keys
    private enum Keys {
        static let hasShownTutorial = "hasShownTutorial"
        static let appLaunchCount = "appLaunchCount"
    }

    // MARK: - Tutorial Management
    var hasShownTutorial: Bool {
        get { bool(forKey: Keys.hasShownTutorial) }
        set { set(newValue, forKey: Keys.hasShownTutorial) }
    }

    var appLaunchCount: Int {
        get { integer(forKey: Keys.appLaunchCount) }
        set { set(newValue, forKey: Keys.appLaunchCount) }
    }

    // MARK: - Methods
    func shouldShowTutorial() -> Bool {
        return !hasShownTutorial
    }

    func markTutorialAsShown() {
        hasShownTutorial = true
    }

    func incrementLaunchCount() {
        appLaunchCount += 1
    }
}