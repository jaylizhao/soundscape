//
//  OnboardingLanguageView.swift
//  Soundscape
//
//  Copyright (c) Microsoft Corporation.
//  Licensed under the MIT License.
//

import SwiftUI

struct OnboardingLanguageView: View {
    
    // MARK: Properties
    
    @State private var selectedLocale: Locale = LocalizationContext.currentAppLocale
    
    @ViewBuilder
    private var destination: some View {
        OnboardingHeadphoneView()
    }
    
    // MARK: `body`
    
    var body: some View {
        OnboardingContainer {
            VStack(spacing: 12.0) {
                GDLocalizedTextView("first_launch.soundscape_language")
                    .onboardingHeaderTextStyle()
                
                GDLocalizedTextView("first_launch.beacon.message.3")
                    .onboardingTextStyle(font: .callout)
            }
            
            // Allows user to select a preferred language
            LanguagePickerView(selectedLocale: $selectedLocale)
            
            // Continue button to save new language selection and proceed onto the app
            Button(action: {
                saveLanguageSelection()
                onContinue()
            }) {
                Text(NSLocalizedString("Continue", comment: ""))
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .padding(.top, 20)
            }

        }
        .onAppear {
            GDATelemetry.trackScreenView("onboarding.language_picker")
        }
    }
    
    private func saveLanguageSelection() {
        UserDefaults.standard.set(selectedLocale.identifier, forKey: "selectedLanguage")
        NotificationCenter.default.post(name: NSNotification.Name("LanguageSelected"), object: nil)
    }
    
    let onContinue: () -> Void

    init(onContinue: @escaping () -> Void = {}) {
        self.onContinue = onContinue
    }
}

struct OnboardingLanguageView_Previews: PreviewProvider {
    
    static var previews: some View {
        OnboardingLanguageView()
    }
}

func saveUserPreferredLanguage(_ language: String) {
    // Saves the selected language in UserDefaults or other persistence mechanisms
    UserDefaults.standard.set([language], forKey: "AppleLanguages")
    UserDefaults.standard.synchronize()
}


