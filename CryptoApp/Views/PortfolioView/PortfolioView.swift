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
      
      List(vm.portfolioCoins) { coin in
        CoinRowView(coin: coin, showHoldingsColumn: true)
          .listRowSeparator(.hidden)
      }
    }
    .listStyle(.inset)
    .scrollIndicators(.hidden)
    .refreshable {
      vm.reloadData()
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
