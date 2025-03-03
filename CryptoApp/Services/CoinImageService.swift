import SwiftUI
import Combine

class CoinImageService {
  @Published var image: UIImage?
  private var imageSubs: AnyCancellable?
  private let coin: CoinModel
  
  init(coin: CoinModel) {
    self.coin = coin
    getCoinImage()
  }
  
  private func getCoinImage() {
    guard let url = URL(string: coin.image) else { return }
    
    imageSubs = NetworkManager.download(url: url)
      .tryMap({ data in
        return UIImage(data: data)
      })
      .sink(receiveCompletion:  NetworkManager.handleCompletion, receiveValue: { [weak self] image in
        self?.image = image
        self?.imageSubs?.cancel()
      })
  }
}
