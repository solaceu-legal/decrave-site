import SwiftUI

struct PackPriceEditorView: View {
    @Binding var pricePerPack: Double
    @Binding var currencyCode: String
    @Environment(\.dismiss) private var dismiss

    @State private var draftPrice: Double
    @State private var draftCurrency: String

    init(pricePerPack: Binding<Double>, currencyCode: Binding<String>) {
        _pricePerPack = pricePerPack
        _currencyCode = currencyCode
        _draftPrice = State(initialValue: pricePerPack.wrappedValue)
        _draftCurrency = State(initialValue: currencyCode.wrappedValue)
    }

    var body: some View {
        NavigationStack {
            Form {
                PackPriceFields(pricePerPack: $draftPrice, currencyCode: $draftCurrency)
                Text(Strings.Money.explanation)
                    .font(.footnote)
                    .foregroundStyle(.secondary)
            }
            .navigationTitle(Strings.Money.packPrice)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(Strings.Money.cancel) { dismiss() }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button(Strings.Money.save) {
                        pricePerPack = draftPrice
                        currencyCode = draftCurrency
                        dismiss()
                    }
                    .disabled(!draftPrice.isFinite || draftPrice <= 0)
                }
            }
        }
    }
}
