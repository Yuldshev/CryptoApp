import SwiftUI

struct CoinImageView: View {
  //MARK: - Properties
  @StateObject var vm: CoinImageViewModel
  
  init(coin: CoinModel) {
    _vm = StateObject(wrappedValue: CoinImageViewModel(coin: coin))
  }
  
  //MARK: - Body
  var body: some View {
    ZStack {
      if let image = vm.image {
        Image(uiImage: image)
          .resizable()
          .scaledToFill()
      } else if vm.isLoading {
        ProgressView()
      } else {
        Image(systemName: "questionmark")
          .font(.headline)
          .foregroundStyle(.secondary)
      }
    }
  }
}

#Preview {
  CoinImageView(coin: DeveloperPreview.instance.coin)
}
