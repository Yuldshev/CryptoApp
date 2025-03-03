import SwiftUI

struct CoinsView: View {
  //MARK: - Properties
  @EnvironmentObject private var vm: CoinViewModel
  @State private var searchText = ""
  
  //MARK: - Body
  var body: some View {
    ScrollView(.vertical, showsIndicators: false) {
      CryptoStatsView(barData: true)
        .padding(.top, 10)
      
      SortBarView(isShowHolding: false)
        .padding(.top, 20)
      
      ForEach(vm.allCoins) { coin in
        CoinRowView(coin: coin, showHoldingsColumn: false)
      }
    }
    .navigationTitle("Live prices")
    .searchable(text: $searchText, prompt: "Search")
  }
}

//MARK: - Preview
#Preview {
  CoinsView()
    .environmentObject(CoinViewModel())
}
