import SwiftUI
import Combine

class CoinImageService {
  @Published var image: UIImage?
  private var imageSubs: AnyCancellable?
  private let coin: CoinModel
  private let fileManager = LocalFileManager.instance
  private let folderName = "coin_images"
  private let imageName: String
  
  init(coin: CoinModel) {
    self.coin = coin
    self.imageName = coin.id
    getCoinImage()
    
  }
  
  private func getCoinImage() {
    if let savedImage = fileManager.getImage(imageName: imageName, folderName: folderName) {
      image = savedImage
    } else {
      downloadCoinImage()
    }
  }
  
  private func downloadCoinImage() {
    guard let url = URL(string: coin.image) else { return }
    
    imageSubs = NetworkManager.download(url: url)
      .tryMap({ data in
        return UIImage(data: data)
      })
      .sink(receiveCompletion:  NetworkManager.handleCompletion, receiveValue: { [weak self] image in
        guard let self = self, let dowloadImage = image else { return }
        self.image = image
        self.imageSubs?.cancel()
        self.fileManager.saveImage(image: dowloadImage, imageName: self.imageName, folderName: self.folderName)
      })
  }
}
