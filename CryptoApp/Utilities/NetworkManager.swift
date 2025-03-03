import Foundation
import Combine

class NetworkManager {
  enum NetworkError: LocalizedError {
    case badURLResponse
    case unknown
    
    var errorDescription: String? {
      switch self {
        case .badURLResponse:
          return "[🔥] Bad response from URL"
        case .unknown:
          return "[⚠️] Unknown error"
      }
    }
  }
  
  static func download(url: URL) -> AnyPublisher<Data, Error> {
    return URLSession.shared.dataTaskPublisher(for: url)
      .subscribe(on: DispatchQueue.global(qos: .default))
      .tryMap { try handleURLResponse(output: $0)}
      .receive(on: DispatchQueue.main)
      .eraseToAnyPublisher()
  }
  
  static func handleURLResponse(output: URLSession.DataTaskPublisher.Output) throws -> Data {
    guard let response = output.response as? HTTPURLResponse,
          response.statusCode >= 200 && response.statusCode < 300 else {
      throw NetworkError.badURLResponse
    }
    return output.data
  }
  
  static func handleCompletion(completion: Subscribers.Completion<Error>) {
    switch completion {
      case .finished:
        break
      case .failure(let error):
        print(error.localizedDescription)
    }
  }
}
