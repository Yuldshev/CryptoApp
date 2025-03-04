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
        ForEach(vm.searchText.isEmpty ? vm.portfolioCoins : vm.allCoins, id: \.id) { coin in
          PortfolioCoinView(coin: coin)
            .onTapGesture {
              withAnimation(.easeIn) {
                updateCoin(coin: coin)
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
          .onChange(of: quantityText) { newValue, oldValue in
            quantityText = newValue.replacingOccurrences(of: ",", with: ".")
          }
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
    guard
      let coin = selectCoin,
      let amount = Double(quantityText)
    else { return }
    
    vm.updatePortfolio(coin: coin, amount: amount)
    dismiss()
  }
  
  private func updateCoin(coin: CoinModel) {
    selectCoin = coin
    
    if let portfolioCoin = vm.portfolioCoins.first(where: { $0.id == coin.id }),
       let amount = portfolioCoin.currentHoldings {
      quantityText = "\(amount)"
    } else {
      quantityText = ""
    }
  }
}

//MARK: - Preview
#Preview {
  NavigationStack {
    EditPortfolioView().environmentObject(CoinViewModel())
  }
}
