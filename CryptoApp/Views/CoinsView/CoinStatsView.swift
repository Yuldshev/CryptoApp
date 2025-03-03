import SwiftUI

struct CoinStatsView: View {
  //MARK: - Properties
  @EnvironmentObject private var vm: CoinViewModel
  var showPortfolio: Bool
  
  //MARK: - Body
  var body: some View {
    HStack(spacing: 0) {
      ForEach(vm.stat, id: \.id) { stat in
        StatsView(stat: stat)
          .frame(width: UIScreen.main.bounds.width / 3)
      }
    }
    .frame(width: UIScreen.main.bounds.width,
           alignment: showPortfolio ? .trailing : .leading)
  }
}

#Preview {
  CoinStatsView(showPortfolio: true)
    .environmentObject(CoinViewModel())
}
