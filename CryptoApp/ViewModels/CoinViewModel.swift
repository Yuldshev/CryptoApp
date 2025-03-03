import Foundation
import Combine

class CoinViewModel: ObservableObject {
  @Published var allCoins: [CoinModel] = []
  @Published var portfolioCoins: [CoinModel] = []
  
  private let dataService = CoinDataService()
  private var cancellables = Set<AnyCancellable>()
  
  init() {
    addSubs()
  }
  
  func addSubs() {
    dataService.$allCoins
      .sink { [weak self] coin in
        self?.allCoins = coin
      }
      .store(in: &cancellables)
  }
}
