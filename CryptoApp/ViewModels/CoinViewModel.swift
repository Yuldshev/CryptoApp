import Foundation
import Combine

class CoinViewModel: ObservableObject {
  @Published var allCoins: [CoinModel] = []
  @Published var portfolioCoins: [CoinModel] = []
  @Published var searchText = ""
  @Published var stat: [StatsModel] = []
  @Published var isLoading = false
  
  private let coinDataService = CoinDataService()
  private let marketDataService = MarketDataService()
  private let portfolioDataService = PortfolioDataService()
  private var cancellables = Set<AnyCancellable>()
  
  init() {
    addSubs()
  }
  
  func addSubs() {
    $searchText
      .combineLatest(coinDataService.$allCoins)
      .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
      .map(filterCoins)
      .sink { [weak self] coins in
        self?.allCoins = coins
      }
      .store(in: &cancellables)
    
    $allCoins
      .combineLatest(portfolioDataService.$saveEntity)
      .map(mapAllCoins)
      .sink { [weak self] coin in
        self?.portfolioCoins = coin
      }
      .store(in: &cancellables)
    
    marketDataService.$marketData
      .combineLatest($portfolioCoins)
      .map(mapMarketData)
      .sink { [weak self] stats in
        self?.stat = stats
        self?.isLoading = false
      }
      .store(in: &cancellables)
    
    
  }
  
  func updatePortfolio(coin: CoinModel, amount: Double) {
    portfolioDataService.updatePortfolio(coin: coin, amount: amount)
  }
  
  func reloadData() {
    isLoading = true
    coinDataService.getCoins()
    marketDataService.getData()
    HapticManager.notification(type: .success)
  }
  
  private func filterCoins(text: String, coins: [CoinModel]) -> [CoinModel] {
    guard !text.isEmpty else { return coins }
    let lowercasedText = text.lowercased()
    return coins.filter { coin -> Bool in
      return coin.name.lowercased().contains(lowercasedText) ||
              coin.symbol.lowercased().contains(lowercasedText) ||
              coin.id.lowercased().contains(lowercasedText)
    }
  }
  
  private func mapAllCoins(coinModels: [CoinModel], entity: [Portfolio]) -> [CoinModel] {
    coinModels.compactMap { coin -> CoinModel? in
      guard let entity = entity.first(where: { $0.coinID == coin.id }) else {
        return nil
      }
      return coin.updateHoldings(amount: entity.amount)
    }
  }
  
  private func mapMarketData(market: MarketDataModel?, portfolioCoins: [CoinModel]) -> [StatsModel] {
    var stats: [StatsModel] = []
    
    guard let data = market else { return stats }
    
    let marketCap = StatsModel(title: "Market Cap", value: data.marketCap, percent: data.marketCapChangePercentage24HUsd)
    let volume = StatsModel(title: "24h volume", value: data.volume)
    let btcDominance = StatsModel(title: "BTC Dominance", value: data.btcDominance)
    
    let portfolioValue = portfolioCoins
      .map{ $0.currentHoldingsValue}
      .reduce(0, +)
    let previousValue = portfolioCoins
      .map{ coin -> Double in
        let currentValue = coin.currentHoldingsValue
        let percentChange = coin.priceChangePercentage24H ?? 0 / 100
        let previousValue = currentValue / (1 + percentChange)
        return previousValue
      }
      .reduce(0, +)
    let percentageChange = ((portfolioValue - previousValue) / previousValue) * 100
    
    let portfolio = StatsModel(title: "Portfolio Value", value: portfolioValue.asCurrencyDecimals2(), percent: percentageChange)
    
    stats.append(contentsOf: [marketCap, volume, btcDominance, portfolio])
    return stats
  }
}
