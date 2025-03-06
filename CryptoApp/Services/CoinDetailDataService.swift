import Foundation
import Combine

class CoinDetailDataService {
  @Published var coinDetails: CoinDetailModel?
  let coin: CoinModel
  var coinDetailSubs: AnyCancellable?
  
  init(coin: CoinModel) {
    self.coin = coin
    getCoinsDetails()
  }
  
  func getCoinsDetails() {
    guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/\(coin.id)?localization=false&tickers=false&market_data=false&community_data=false&developer_data=false&sparkline=false") else { return }
    
    coinDetailSubs = NetworkManager.download(url: url)
      .decode(type: CoinDetailModel.self, decoder: JSONDecoder())
      .sink(receiveCompletion:  NetworkManager.handleCompletion, receiveValue: { [weak self] coin in
        self?.coinDetails = coin
        self?.coinDetailSubs?.cancel()
      })
  }
}
