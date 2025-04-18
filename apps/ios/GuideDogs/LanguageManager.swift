//
//  LanguageManager.swift
//  Soundscape
//
//  Copyright (c) Microsoft Corporation.
//  Licensed under the MIT License.
//

import Foundation
import SwiftUI

/// LanguageManager handles the app's language selection flow,
/// particularly when the app's language differs from the device language.
/// This includes presenting the language onboarding screen and updating the root view controller.
class LanguageManager {
    /// Called during app launch to determine if the user needs to select a language.
    /// If the user has not yet completed language selection during onboarding, it presents the onboarding language screen.
    static func initializeLanguageFlow(window: UIWindow?) {
        if !FirstUseExperience.didComplete(.selectedLanguage) {
            presentLanguageScreen(window: window)
        }
    }
    
    /// Checks if there's a mismatch between the device language and the app's current language.
    /// If a mismatch is found and the onboarding screen is not already visible, it presents the language selection screen to the user.
    static func checkAndPromptForLanguageMismatch(window: UIWindow?) {
        let phoneLanguage = Locale.current.languageCode ?? "en"
        let appLanguage = LocalizationContext.currentAppLocale.languageCode ?? "en"

        if phoneLanguage != appLanguage {
            // Avoids showing the language selection menu again if it's already being shown
            if !(window?.rootViewController is UIHostingController<OnboardingLanguageView>) {
                presentLanguageScreen(window: window)
            }
        }
    }

    /// Presents the language selection screen as the main interface.
    /// This allows users to pick and change to their preferred app language.
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

    /// Called after the user selects a new language.
    /// Sets the main app view controller as the root.
    private static func languageSelected(window: UIWindow?) {
        let mainVC = DynamicLaunchViewController()
        window?.rootViewController = mainVC
        window?.makeKeyAndVisible()
    }
}

