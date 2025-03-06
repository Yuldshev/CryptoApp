import Foundation
import Combine

class CoinDetailDataService {
  @Published var coinDetails: CoinDetailModel?
  private var cancellables = Set<AnyCancellable>()
  let coin: CoinModel
  
  init(coin: CoinModel) {
    self.coin = coin
    getCoinsDetails()
  }
  
  func getCoinsDetails() {
    guard let url = Endpoint.coinDetailData(coinId: coin.id) else { return }
    
    NetworkManager.download(url: url)
      .decode(type: CoinDetailModel.self, decoder: JSONDecoder())
      .sink(receiveCompletion:  NetworkManager.handleCompletion, receiveValue: { [weak self] details in
        self?.coinDetails = details
      })
      .store(in: &cancellables)
  }
}
