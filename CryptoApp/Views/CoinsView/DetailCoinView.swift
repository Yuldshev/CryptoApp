import SwiftUI

struct DetailCoinView: View {
  //MARK: - Properties
  @StateObject private var vm: CoinDetailViewModel
  @State var showFullDescription = false
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
      VStack(alignment: .leading, spacing: 20) {
        ChartView(coin: vm.coin)
          .frame(height: 150)
          .padding(.vertical, 10)
        
        overviewTitle
          .padding(.top, 30)
        
        descriptionSection
        
        OverviewView(stats: vm.overviewStats, columns: column)
        
        Divider()
        AdditionalView(stats: vm.additionalStats, columns: column)
        Divider()
        websiteSection
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
  
  private var overviewTitle: some View {
    VStack(alignment: .leading) {
      Text("Overview")
        .font(.title2).bold()
    }
  }
  
  private var descriptionSection: some View {
    VStack {
      if let description = vm.coinDescription, !description.isEmpty {
        VStack(alignment: .leading) {
          Text(description)
            .lineLimit(showFullDescription ? nil : 3)
          
          Button {
            withAnimation(.smooth()) {
              showFullDescription.toggle()
            }
          } label: {
            Text(showFullDescription ? "Less" : "Read more...")
              .bold()
              .foregroundStyle(.red)
              .padding(.vertical, 4)
          }
        }
        .font(.caption)
      }
    }
  }
  
  private var websiteSection: some View {
    VStack {
      Text("Links")
        .font(.title2).bold()
        .frame(maxWidth: .infinity, alignment: .leading)
      LazyVGrid(columns: column, alignment: .leading, spacing: 30) {
        if let websiteURL = vm.websiteURL, let url = URL(string: websiteURL) {
          Link(destination: url) {
            Label("Website", systemImage: "link")
          }
        }
        
        if let redditURL = vm.redditURL, let url = URL(string: redditURL) {
          Link(destination: url) {
            Label("Reddit", systemImage: "link")
          }
        }
      }
      .font(.subheadline)
      .bold()
      .foregroundStyle(.red)
    }
  }
}

//MARK: - Overview View
struct OverviewView: View {
  let stats: [StatsModel]
  let columns: [GridItem]
  
  var body: some View {
    VStack(alignment: .leading, spacing: 10) {
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
