import Foundation

protocol CoinIdentifiable: Identifiable {
    var id: String { get }
    var symbol: String { get }
    var name: String { get }
}

struct CoinDetailModel: CoinIdentifiable, Codable {
  let id, symbol, name: String
  let blockTimeInMinutes: Int?
  let hashingAlgorithm: String?
  let description: Description?
  let links: Links?
  
  enum CodingKeys: String, CodingKey {
    case id, symbol, name, description, links
    case blockTimeInMinutes = "block_time_in_minutes"
    case hashingAlgorithm = "hashing_algorithm"
  }
}

//MARK: - Description
struct Description: Codable {
    let en: String?
}

//MARK: - Links
struct Links: Codable {
    let homepage: [String]?
    let subredditURL: String?
  
  enum CodingKeys: String, CodingKey {
    case homepage
    case subredditURL = "subreddit_url"
  }
}

