//
//  LanguageManager.swift
//  Soundscape
//
//  Copyright (c) Microsoft Corporation.
//  Licensed under the MIT License.
//

import Foundation
import SwiftUI

class LanguageManager {
    static func initializeLanguageFlow(window: UIWindow?) {
        // First-time use case
        if !FirstUseExperience.didComplete(.selectedLanguage) {
            presentLanguageScreen(window: window)
        }
    }

    static func checkAndPromptForLanguageMismatch(window: UIWindow?) {
        let phoneLanguage = Locale.current.languageCode ?? "en"
        let appLanguage = LocalizationContext.currentAppLocale.languageCode ?? "en"

        if phoneLanguage != appLanguage {
            // Optional: skip if already on onboarding screen to prevent looping
            if !(window?.rootViewController is UIHostingController<OnboardingLanguageView>) {
                presentLanguageScreen(window: window)
            }
        }
    }

    private static func presentLanguageScreen(window: UIWindow?) {
        DispatchQueue.main.async {
            let view = OnboardingLanguageView {
                languageSelected(window: window)
            }
            let vc = UIHostingController(rootView: view)
            window?.rootViewController = vc
            window?.makeKeyAndVisible()
        }
    }

    private static func languageSelected(window: UIWindow?) {
        let mainVC = DynamicLaunchViewController()
        window?.rootViewController = mainVC
        window?.makeKeyAndVisible()
    }
    
    
}

