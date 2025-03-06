import Foundation
import Combine

class CoinDetailViewModel: ObservableObject {
  @Published var overviewStats: [StatsModel] = []
  @Published var additionalStats: [StatsModel] = []
  @Published var coin: CoinModel
  @Published var coinDescription: String?
  @Published var websiteURL: String?
  @Published var redditURL: String?
  
  private let coinDetailService: CoinDetailDataService
  private var cancellables = Set<AnyCancellable>()
  
  init(coin: CoinModel) {
    self.coin = coin
    self.coinDetailService = CoinDetailDataService(coin: coin)
    addSubs()
  }
  
  private func addSubs() {
    coinDetailService.$coinDetails
      .combineLatest($coin)
      .map(mapDataStats)
      .sink { [weak self] array in
        self?.overviewStats = array.overview
        self?.additionalStats = array.additional
      }
      .store(in: &cancellables)
    
    coinDetailService.$coinDetails
      .sink { [weak self] coin in
        self?.coinDescription = coin?.description?.en
        self?.websiteURL = coin?.links?.homepage?.first
        self?.redditURL = coin?.links?.subredditURL
      }
      .store(in: &cancellables)
  }
  
  private func mapDataStats(coinDetailModel: CoinDetailModel?, coinModel: CoinModel) -> (overview: [StatsModel], additional: [StatsModel]) {
    let overviewArray = createOverviewArray(coinModel: coinModel)
    let additionalArray = createAdditionalArray(coinModel: coinModel, coinDetailModel: coinDetailModel)
    return (overviewArray, additionalArray)
  }
  
  private func createOverviewArray(coinModel: CoinModel) -> [StatsModel] {
    let price = coinModel.currentPrice.asCurrencyDecimals6()
    let pricePercentChange = coinModel.priceChangePercentage24H
    let priceStat = StatsModel(title: "Current Price", value: price, percent: pricePercentChange)
    
    let marketCap = "$" + (coinModel.marketCap?.formattedWithAbbreviations() ?? "n/a")
    let marketCapPercentChange = coinModel.marketCapChangePercentage24H
    let marketStat = StatsModel(title: "Market Cap", value: marketCap, percent: marketCapPercentChange)
    
    let rank = coinModel.rank.description
    let rankStat = StatsModel(title: "Rank", value: rank)
    
    let volume = "$" + (coinModel.totalVolume?.formattedWithAbbreviations() ?? "n/a")
    let volumeStat = StatsModel(title: "Volume", value: volume)
    
    let overviewArray: [StatsModel] = [priceStat, marketStat, rankStat, volumeStat]
    return overviewArray
  }
  
  private func createAdditionalArray(coinModel: CoinModel, coinDetailModel: CoinDetailModel?) -> [StatsModel] {
    let high = coinModel.high24H?.asCurrencyDecimals6() ?? "n/a"
    let highStat = StatsModel(title: "24h High", value: high)
    
    let low = coinModel.low24H?.asCurrencyDecimals6() ?? "n/a"
    let lowStat = StatsModel(title: "24h Low", value: low)
    
    let priceChange = coinModel.priceChange24H?.asCurrencyDecimals6() ?? "n/a"
    let pricePercentChange = coinModel.priceChangePercentage24H
    let priceChangeStat = StatsModel(title: "24h Price Change", value: priceChange, percent: pricePercentChange)
    
    let marketChange = "$" + (coinModel.marketCapChange24H?.formattedWithAbbreviations() ?? "n/a")
    let marketCapPercentChange = coinModel.marketCapChangePercentage24H
    let marketCapChangeStat = StatsModel(title: "24h Market Change", value: marketChange, percent: marketCapPercentChange)
    
    let blockTimeString = coinDetailModel?.blockTimeInMinutes.map { "\($0)" } ?? "n/a"
    let blockTimeStat = StatsModel(title: "Block Time", value: blockTimeString)
    
    let hashing = coinDetailModel?.hashingAlgorithm ?? "n/a"
    let hashingStat = StatsModel(title: "Hashing Algorithm", value: hashing)
    
    let additionalArray: [StatsModel] = [highStat, lowStat, priceChangeStat, marketCapChangeStat, blockTimeStat, hashingStat]
    return additionalArray
  }
}
