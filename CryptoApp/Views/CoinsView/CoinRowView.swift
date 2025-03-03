import SwiftUI

//MARK: - Main View
struct CoinRowView: View {
  
  //MARK: - Properties
  var coin: CoinModel
  var showHoldingsColumn: Bool
  
  //MARK: - Body
  var body: some View {
    HStack(spacing: 0) {
      lefColumn
      Spacer()
      if showHoldingsColumn {
        centerColumn
      }
      rightColumn
    }
    .padding(.horizontal, 20)
    .padding(.vertical, 10)
  }
}

//MARK: - View Column
extension CoinRowView {
  private var lefColumn: some View {
    HStack(spacing: 18) {
      RoundedRectangle(cornerRadius: 18)
        .frame(width: 56, height: 56)
        .foregroundStyle(.orange.opacity(0.1))
      Text(coin.symbol.uppercased())
        .font(.title3)
        .bold()
    }
  }
  
  private var centerColumn: some View {
    VStack(alignment: .trailing) {
      Text(coin.currentHoldingsValue.asCurrencyDecimals2())
        .font(.headline)
      Text((coin.currentHoldings ?? 0).asNumberString())
        .font(.subheadline)
        .foregroundStyle(.secondary)
    }
  }
  
  private var rightColumn: some View {
    VStack(alignment: .trailing) {
      Text(coin.currentPrice.asCurrencyDecimals6())
        .font(.headline)
      
      Text(coin.priceChangePercentage24H?.asPercentString() ?? "")
        .font(.subheadline)
        .foregroundStyle(.secondary)
    }
    .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
  }
}

//MARK: - Preview
#Preview {
  CoinRowView(coin: DeveloperPreview.instance.coin, showHoldingsColumn: true)
}
