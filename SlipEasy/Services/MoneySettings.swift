import Foundation

enum MoneySettings {
    static let currencyStorageKey = "priceCurrencyCode"

    static var deviceCurrencyCode: String {
        Locale.current.currency?.identifier ?? "USD"
    }

    static var currencyCode: String {
        UserDefaults.standard.string(forKey: currencyStorageKey) ?? deviceCurrencyCode
    }

    /// Existing prices were entered in the device's currency. Save that
    /// currency once so a later region change cannot relabel old amounts.
    static func preserveExistingCurrency() {
        let defaults = UserDefaults.standard
        guard defaults.string(forKey: currencyStorageKey) == nil else { return }
        defaults.set(deviceCurrencyCode, forKey: currencyStorageKey)
    }

    static var currencyCodes: [String] {
        Locale.commonISOCurrencyCodes.sorted()
    }

    static func currencyName(for code: String) -> String {
        AppLanguage.current.locale.localizedString(forCurrencyCode: code) ?? code
    }
}
