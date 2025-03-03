import SwiftUI

struct CoinsView: View {
  //MARK: - Properties
  @EnvironmentObject private var vm: CoinViewModel
  
  //MARK: - Body
  var body: some View {
    ScrollView(.vertical, showsIndicators: false) {
      CryptoStatsView(barData: true)
        .padding(.top, 10)
      
      SortBarView(isShowHolding: false)
        .padding(.top, 20)
      
      
      LazyVStack(spacing: 0) {
        ForEach(vm.allCoins) { coin in
          CoinRowView(coin: coin, showHoldingsColumn: false)
        }
      }
    }
    .navigationTitle("Live prices")
    .searchable(text: $vm.searchText, prompt: "Search")
    .autocorrectionDisabled(true)
    .textInputAutocapitalization(.never)
    .keyboardType(.webSearch)
  }
}

//MARK: - Preview
#Preview {
  CoinsView()
    .environmentObject(CoinViewModel())
}
