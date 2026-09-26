//
//  AppLanguage.swift
//  SlipEasy
//

import Foundation

/// The in-app language preference. English remains the default so existing
/// installs keep their current copy until the user chooses another language.
enum AppLanguage: String, CaseIterable, Identifiable {
    case system
    case english = "en"
    case simplifiedChinese = "zh-Hans"
    case traditionalChinese = "zh-Hant"
    case german = "de"
    case french = "fr"
    case italian = "it"
    case spanish = "es"
    case portuguese = "pt-BR"
    case japanese = "ja"
    case korean = "ko"

    static let storageKey = "appLanguageCode"

    var id: String { rawValue }

    /// Native names are easier to recognize in a language picker than a
    /// translated name that changes while the picker is open.
    var displayName: String {
        switch self {
        case .system: Strings.localized("Follow device", [
            .simplifiedChinese: "跟随系统", .traditionalChinese: "跟隨系統", .german: "Gerätesprache",
            .french: "Langue de l’appareil", .italian: "Lingua del dispositivo", .spanish: "Idioma del dispositivo",
            .portuguese: "Idioma do aparelho", .japanese: "端末の設定に合わせる", .korean: "기기 언어 따르기"
        ])
        case .english: "English"
        case .simplifiedChinese: "简体中文"
        case .traditionalChinese: "繁體中文"
        case .german: "Deutsch"
        case .french: "Français"
        case .italian: "Italiano"
        case .spanish: "Español"
        case .portuguese: "Português"
        case .japanese: "日本語"
        case .korean: "한국어"
        }
    }

    var locale: Locale {
        switch self {
        case .system:
            Locale.current
        default:
            Locale(identifier: rawValue)
        }
    }

    /// Maps the device's locale back to one of the supported in-app
    /// languages. This keeps the "Follow Device" option consistent with the
    /// explicit language choices used by the copy helpers.
    var effective: AppLanguage {
        guard self == .system else { return self }

        let deviceLocale = Locale.current
        let languageCode = deviceLocale.language.languageCode?.identifier ?? "en"

        switch languageCode {
        case "zh":
            let script = deviceLocale.language.script?.identifier
            let region = deviceLocale.region?.identifier
            return script == "Hant" || (script == nil && ["TW", "HK", "MO"].contains(region ?? ""))
                ? .traditionalChinese : .simplifiedChinese
        case "de": return .german
        case "fr": return .french
        case "it": return .italian
        case "es": return .spanish
        case "pt": return .portuguese
        case "ja": return .japanese
        case "ko": return .korean
        default: return .english
        }
    }

    static var current: AppLanguage {
        let rawValue = UserDefaults.standard.string(forKey: storageKey) ?? AppLanguage.english.rawValue
        return AppLanguage(rawValue: rawValue) ?? .system
    }
}
