import SwiftUI

struct CoinsView: View {
  //MARK: - Properties
  @EnvironmentObject private var vm: CoinViewModel
  
  //MARK: - Body
  var body: some View {
    VStack {
      CoinStatsView(showPortfolio: false)
        .environmentObject(vm)
      
      SortBarView(isShowHolding: false)
        .environmentObject(vm)
        .padding(.top, 20)
      
      
      List(vm.allCoins) { coin in
        NavigationLink { LazyView(DetailCoinView(coin: coin)) } label: {
          CoinRowView(coin: coin, showHoldingsColumn: false)
            .listRowSeparator(.hidden)
        }
      }
      .listStyle(.plain)
      .scrollIndicators(.hidden)
      .refreshable {
        vm.reloadData()
      }
      .navigationTitle("Live prices")
      .searchable(text: $vm.searchText, prompt: "Search")
      .keyboardType(.webSearch)
    }
  }
}

//MARK: - LazyView
struct LazyView<Content: View>: View {
  let build: () -> Content
  
  init(_ build: @autoclosure @escaping () -> Content) {
    self.build = build
  }
  
  var body: Content {
    build()
  }
}

//MARK: - Preview
#Preview {
  NavigationStack {
    CoinsView()
      .environmentObject(CoinViewModel())
  }
}
