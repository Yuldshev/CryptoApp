import SwiftUI

struct PortfolioView: View {
  //MARK: - Properties
  @EnvironmentObject private var vm: CoinViewModel
  @State private var showPortfolio = false
  
  //MARK: - Body
  var body: some View {
    ScrollView(.vertical, showsIndicators: false) {
      CoinStatsView(showPortfolio: true)
        .environmentObject(vm)
      
      SortBarView(isShowHolding: true)
        .padding(.top, 20)
      
      LazyVStack(spacing: 0) {
        ForEach(vm.portfolioCoins) { coin in
          CoinRowView(coin: coin, showHoldingsColumn: true)
        }
      }
    }
    .navigationTitle("Portfolio")
    .searchable(text: $vm.searchText, prompt: "Search")
    .keyboardType(.webSearch)
    .toolbar {
      ToolbarItem {
        Button("Add coin") {
          showPortfolio.toggle()
        }
      }
    }
    .sheet(isPresented: $showPortfolio) {
      NavigationStack {
        EditPortfolioView()
          .environmentObject(vm)
      }
    }
  }
}

#Preview {
  NavigationStack {
    PortfolioView()
      .environmentObject(CoinViewModel())
  }
}
