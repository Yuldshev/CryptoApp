import Foundation
import CoreData

class PortfolioDataService {
  @Published var saveEntity: [Portfolio] = []
  
  private let container: NSPersistentContainer
  private let containerName = "PortfolioContainer"
  
  init() {
    container = NSPersistentContainer(name: containerName)
    container.loadPersistentStores { _, error in
      if let error = error {
        print("Error loading Core Data! \(error)")
      }
      self.getPortfolio()
    }
  }
  
  //MARK: - Public
  func updatePortfolio(coin: CoinModel, amount: Double) {
    if let entity = saveEntity.first(where: { $0.coinID == coin.id }) {
      if amount > 0 {
        update(entity: entity, amount: amount)
      } else {
        delete(entity: entity)
      }
    } else {
      add(coin: coin, amount: amount)
    }
  }
  
  //MARK: - Private
  private func getPortfolio() {
    let requst = NSFetchRequest<Portfolio>(entityName: "Portfolio")
    do {
      saveEntity = try container.viewContext.fetch(requst)
    } catch let error {
      print("Error fetching data! \(error)")
    }
  }
  
  private func add(coin: CoinModel, amount: Double) {
    let entity = Portfolio(context: container.viewContext)
    entity.coinID = coin.id
    entity.amount = amount
    applyChanges()
  }
  
  private func update(entity: Portfolio, amount: Double) {
    entity.amount = amount
    applyChanges()
  }
  
  private func save() {
    do {
      try container.viewContext.save()
    } catch let error {
      print("Error save context! \(error)")
    }
  }
  
  private func delete(entity: Portfolio) {
    container.viewContext.delete(entity)
    applyChanges()
  }
  
  private func applyChanges() {
    save()
    getPortfolio()
  }
}

