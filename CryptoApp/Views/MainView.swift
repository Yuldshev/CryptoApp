import SwiftUI

struct MainView: View {
  //MARK: - Properties
  @EnvironmentObject private var vm: CoinViewModel
  
  //MARK: - Body
  var body: some View {
    TabView {
      NavigationStack {
        CoinsView()
          .environmentObject(vm)
          .navigationTitle("Live prices")
          .searchable(text: $vm.searchText, prompt: "Search")
          .keyboardType(.webSearch)
          }
      .tabItem {
        Label("Coins", systemImage: "bitcoinsign.circle")
      }
      
      NavigationStack {
        PortfolioView()
          .environmentObject(vm)
          .navigationTitle("Portfolio")
          .searchable(text: $vm.searchText, prompt: "Search")
          .keyboardType(.webSearch)
          }
      .tabItem {
        Label("Portfolio", systemImage: "bag.fill")
      }
      
      NavigationStack {
        ProfileView()
          .navigationTitle("Profile")
          .navigationBarTitleDisplayMode(.inline)
          
      }
      .tabItem {
        Label("Profile", systemImage: "person")
      }
    }
    .tint(.red)
  }
}

#Preview {
  MainView()
    .environmentObject(CoinViewModel())
}
