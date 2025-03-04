import Foundation
import Combine

class CoinDataService {
  @Published var allCoins: [CoinModel] = []
  var coinSubs: AnyCancellable?
  
  init() {
    getCoins()
  }
  
  func getCoins() {
    guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=50&page=1&sparkline=true&price_change_percentage=24h") else { return }
    
    coinSubs = NetworkManager.download(url: url)
      .decode(type: [CoinModel].self, decoder: JSONDecoder())
      .sink(receiveCompletion:  NetworkManager.handleCompletion, receiveValue: { [weak self] coin in
        self?.allCoins = coin
        self?.coinSubs?.cancel()
      })
  }
}
