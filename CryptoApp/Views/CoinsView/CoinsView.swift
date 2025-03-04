import SwiftUI

struct CoinsView: View {
  //MARK: - Properties
  @EnvironmentObject private var vm: CoinViewModel
  
  //MARK: - Body
  var body: some View {
    ScrollView(.vertical, showsIndicators: false) {
      CoinStatsView(showPortfolio: false)
        .environmentObject(vm)
      
      SortBarView(isShowHolding: false)
        .padding(.top, 20)
      
      
      LazyVStack(spacing: 0) {
        ForEach(vm.allCoins) { coin in
          CoinRowView(coin: coin, showHoldingsColumn: false)
        }
      }
      .navigationTitle("Live prices")
      .searchable(text: $vm.searchText, prompt: "Search")
      .keyboardType(.webSearch)
    }
  }
}

//MARK: - Preview
#Preview {
  NavigationStack {
    CoinsView()
      .environmentObject(CoinViewModel())
  }
}
