import SwiftUI

struct CoinsView: View {
  @State var searchText = ""
  
  var body: some View {
    NavigationStack {
      ScrollView {
        CryptoStatsView(barData: true)
          .padding(.top, 10)
      }
      .navigationTitle("Live prices")
      .searchable(text: $searchText, prompt: "Search")
    }
  }
}

#Preview {
  CoinsView()
}
