import SwiftUI

struct DetailCoinView: View {
  //MARK: - Properties
  let coin: CoinModel
  
  init(coin: CoinModel) {
    self.coin = coin
    print("Coin Detail: \(coin.name)")
  }
  
  //MARK: - Body
  var body: some View {
    Text(coin.name)
  }
}

#Preview {
  DetailCoinView(coin: DeveloperPreview.instance.coin)
}
