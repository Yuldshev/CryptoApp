import SwiftUI

struct PortfolioCoinView: View {
  //MARK: - Properties
  let coin: CoinModel
  
  //MARK: - Body
  var body: some View {
    VStack(spacing: 0) {
      CoinImageView(coin: coin)
        .frame(width: 56, height: 56)
        .padding(.bottom, 4)
      Text(coin.symbol.uppercased())
        .font(.headline)
      Text(coin.name)
        .font(.subheadline)
        .foregroundStyle(.secondary)
    }
    .padding(.horizontal, 6)
    .lineLimit(1)
    .frame(width: 87, height: 112)
    .clipShape(RoundedRectangle(cornerRadius: 18))
  }
}

#Preview {
  PortfolioCoinView(coin: DeveloperPreview.instance.coin)
}
