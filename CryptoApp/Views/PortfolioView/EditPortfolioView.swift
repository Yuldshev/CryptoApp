import SwiftUI

struct EditPortfolioView: View {
  //MARK: - Properties
  @EnvironmentObject private var vm: CoinViewModel
  @Environment(\.dismiss) var dismiss
  @State private var selectCoin: CoinModel?
  @State private var quantityText = ""
  
  //MARK: - Body
  var body: some View {
    ScrollView(.vertical, showsIndicators: false) {
      VStack {
        portfolioScrollView
        
        if selectCoin != nil {
          withAnimation(.easeInOut(duration: 0.2)) {
            addCoinView
              .transition(.move(edge: .bottom))
          }
        }
      }
      .navigationTitle("Edit Portfolio")
      .searchable(text: $vm.searchText, prompt: "Search")
      .keyboardType(.webSearch)
      .toolbar {
        ToolbarItem(placement: .topBarLeading) {
          CustomButton(type: .back, action: { dismiss() })
        }
        ToolbarItem {
          CustomButton(type: .save, action: { savePressed() })
            .opacity(!quantityText.isEmpty ? 1 : 0)
        }
      }
    }
  }
}

//MARK: - CoinView
extension EditPortfolioView {
  var portfolioScrollView: some View {
    ScrollView(.horizontal, showsIndicators: false) {
      LazyHStack(spacing: 10) {
        ForEach(vm.allCoins, id: \.id) { coin in
          PortfolioCoinView(coin: coin)
            .onTapGesture {
              withAnimation(.easeIn) {
                selectCoin = coin
              }
            }
            .background(RoundedRectangle(cornerRadius: 18)
              .stroke(selectCoin?.id == coin.id ? .red : Color.clear))
        }
      }
      .padding(.vertical, 4)
      .padding(.leading)
    }
  }
  
  var addCoinView: some View{
    VStack(spacing: 20) {
      HStack {
        Text("Current price of \(selectCoin?.symbol.uppercased() ?? ""):")
        Spacer()
        Text(selectCoin?.currentPrice.asCurrencyDecimals6() ?? "")
      }
      Divider()
      HStack {
        Text("Amount holding:")
        Spacer()
        TextField("Ex: 1.4", text: $quantityText)
          .multilineTextAlignment(.trailing)
          .keyboardType(.decimalPad)
      }
      Divider()
      HStack {
        Text("Current value:")
        Spacer()
        Text(getCurrentValue().asCurrencyDecimals2())
      }
    }
    .font(.subheadline)
    .padding(20)
  }
  
  private func getCurrentValue() -> Double {
    if let quantity = Double(quantityText) {
      return quantity * (selectCoin?.currentPrice ?? 0)
    }
    return 0
  }
  
  private func savePressed() {
    guard let coin = selectCoin else { return }
  }
}

//MARK: - Preview
#Preview {
  NavigationStack {
    EditPortfolioView().environmentObject(CoinViewModel())
  }
}
