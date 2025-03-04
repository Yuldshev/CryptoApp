import SwiftUI

struct SortBarView: View {
  //MARK: - Properties
  var isShowHolding: Bool
  @EnvironmentObject var vm: CoinViewModel
  
  //MARK: - Body
  var body: some View {
    HStack {
      Text("Coins")
      Spacer()
      if isShowHolding {
        Text("Holdings")
      }
      Text("Price")
        .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
      
      Button {
        withAnimation {
          vm.reloadData()
        }
      } label: {
        Image(systemName: "goforward")
      }
      .rotationEffect(.degrees(vm.isLoading ? 360 : 0))
    }
    .font(.caption)
    .padding(.horizontal, 20)
  }
}

//MARK: - Preview
#Preview {
  SortBarView(isShowHolding: false).environmentObject(CoinViewModel())
}
