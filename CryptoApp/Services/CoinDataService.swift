import Foundation
import Combine

class CoinDataService {
  @Published var allCoins: [CoinModel] = []
  private var cancellables = Set<AnyCancellable>()
  
  init() {
    getCoins()
  }
  
  func getCoins(completion: ((Subscribers.Completion<Error>) -> Void)? = nil) {
    guard let url = Endpoint.coinMarketData() else { return }
    
    NetworkManager.download(url: url)
      .decode(type: [CoinModel].self, decoder: JSONDecoder())
      .sink(receiveCompletion: { result in
        if let completion = completion {
          completion(result)
        }
        NetworkManager.handleCompletion(completion: result)
      }, receiveValue: { [weak self] coins in
        self?.allCoins = coins
      })
      .store(in: &cancellables)
  }
}
