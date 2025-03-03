import SwiftUI

@main
struct CryptoApp: App {
  //MARK: - Properties
  @StateObject private var vm = CoinViewModel()
  
  //MARK: - Body
  var body: some Scene {
    WindowGroup {
      NavigationStack {
        CoinsView()
      }
      .environmentObject(vm)
    }
  }
}
