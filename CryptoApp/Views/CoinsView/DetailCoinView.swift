import SwiftUI

struct DetailCoinView: View {
  //MARK: - Properties
  @StateObject private var vm: CoinDetailViewModel
  @Environment(\.dismiss) var dismiss
  private let column: [GridItem] = [
    GridItem(.flexible()),
    GridItem(.flexible())
  ]
  
  init(coin: CoinModel) {
    _vm = StateObject(wrappedValue: CoinDetailViewModel(coin: coin))
  }
  
  //MARK: - Body
  var body: some View {
    ScrollView(.vertical, showsIndicators: false) {
      VStack(spacing: 20) {
        ChartView(coin: vm.coin)
          .frame(height: 150)
          .padding(.vertical, 10)
        
        OverviewView(stats: vm.overviewStats, columns: column)
          .padding(.top, 30)
        Divider()
        AdditionalView(stats: vm.additionalStats, columns: column)
        Divider()
        Text("Links")
          .font(.title2).bold()
          .frame(maxWidth: .infinity, alignment: .leading)
      }
      .padding(20)
    }
    .navigationTitle(vm.coin.name)
    .navigationBarBackButtonHidden(true)
    .toolbar {
      ToolbarItem(placement: .topBarLeading) {
        CustomButton(type: .back, action: { dismiss() })
      }
    }
  }
}

//MARK: - Overview View
struct OverviewView: View {
  let stats: [StatsModel]
  let columns: [GridItem]
  
  var body: some View {
    VStack(alignment: .leading, spacing: 10) {
      Text("Overview")
        .font(.title2).bold()
      
      LazyVGrid(columns: columns, alignment: .leading, spacing: 30) {
        ForEach(stats) { stat in
          StatsView(stat: stat)
        }
      }
    }
  }
}

//MARK: - Additional View
struct AdditionalView: View {
  let stats: [StatsModel]
  let columns: [GridItem]
  
  var body: some View {
    VStack(alignment: .leading, spacing: 10) {
      Text("Additional Details")
        .font(.title2).bold()
      
      LazyVGrid(columns: columns, alignment: .leading, spacing: 30) {
        ForEach(stats) { stat in
          StatsView(stat: stat)
        }
      }
    }
  }
}

//MARK: - Preview
#Preview {
  NavigationStack {
    DetailCoinView(coin: DeveloperPreview.instance.coin)
  }
}
