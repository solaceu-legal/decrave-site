import SwiftUI

struct PackPriceFields: View {
    @Binding var pricePerPack: Double
    @Binding var currencyCode: String
    @State private var showCurrencies = false

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            VStack(alignment: .leading, spacing: 6) {
                Text(Strings.Money.packPrice)
                    .font(.subheadline.weight(.semibold))
                TextField(Strings.Money.packPrice, value: $pricePerPack, format: .number.locale(AppLanguage.current.locale))
                    .keyboardType(.decimalPad)
                    .font(.title2.monospacedDigit())
                    .padding(14)
                    .background(Color.cardFill, in: RoundedRectangle(cornerRadius: 12))
            }

            Button {
                showCurrencies = true
            } label: {
                HStack {
                    Text(Strings.Money.currency)
                    Spacer()
                    Text("\(currencyCode) · \(MoneySettings.currencyName(for: currencyCode))")
                        .foregroundStyle(.secondary)
                        .lineLimit(1)
                    Image(systemName: "chevron.right")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
                .contentShape(Rectangle())
            }
            .buttonStyle(.plain)
        }
        .sheet(isPresented: $showCurrencies) {
            CurrencySelectionView(selection: $currencyCode)
        }
        .onChange(of: currencyCode) { oldCode, newCode in
            if oldCode != newCode {
                pricePerPack = 0
            }
        }
    }
}

private struct CurrencySelectionView: View {
    @Binding var selection: String
    @Environment(\.dismiss) private var dismiss
    @State private var searchText = ""

    private var filteredCodes: [String] {
        MoneySettings.currencyCodes.filter { code in
            searchText.isEmpty || code.localizedCaseInsensitiveContains(searchText)
                || MoneySettings.currencyName(for: code).localizedCaseInsensitiveContains(searchText)
        }
    }

    var body: some View {
        NavigationStack {
            List(filteredCodes, id: \.self) { code in
                Button {
                    selection = code
                    dismiss()
                } label: {
                    HStack {
                        Text(MoneySettings.currencyName(for: code))
                            .foregroundStyle(.primary)
                        Spacer()
                        Text(code)
                            .foregroundStyle(.secondary)
                        if selection == code {
                            Image(systemName: "checkmark")
                                .foregroundStyle(Color.accentColor)
                        }
                    }
                }
                .buttonStyle(.plain)
            }
            .navigationTitle(Strings.Money.chooseCurrency)
            .searchable(text: $searchText)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(Strings.Money.cancel) { dismiss() }
                }
            }
        }
    }
}
