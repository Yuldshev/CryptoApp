import SwiftUI

struct PortfolioView: View {
  //MARK: - Properties
  @EnvironmentObject private var vm: CoinViewModel
  
  //MARK: - Body
  var body: some View {
    ScrollView(.vertical, showsIndicators: false) {
      CoinStatsView(showPortfolio: true)
        .environmentObject(vm)
      
      SortBarView(isShowHolding: true)
        .padding(.top, 20)
    }
  }
}

#Preview {
  PortfolioView()
    .environmentObject(CoinViewModel())
}
