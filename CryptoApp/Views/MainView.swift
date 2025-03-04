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
          }
      .tabItem {
        Label("Coins", systemImage: "bitcoinsign.circle")
      }
      
      NavigationStack {
        PortfolioView()
          .environmentObject(vm)
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
