import Foundation
import Combine

class MarketDataService {
  @Published var marketData: MarketDataModel?
  var marketDataSubs: AnyCancellable?
  
  init() {
    getData()
  }
  
  private func getData() {
    guard let url = URL(string: "https://api.coingecko.com/api/v3/global") else { return }
    
    marketDataSubs = NetworkManager.download(url: url)
      .decode(type: GlobalData.self, decoder: JSONDecoder())
      .sink(receiveCompletion:  NetworkManager.handleCompletion, receiveValue: { [weak self] globalData in
        self?.marketData = globalData.data
        self?.marketDataSubs?.cancel()
      })
  }
}
