import SwiftUI

struct SortBarView: View {
  //MARK: - Properties
  var isShowHolding: Bool
  
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
    }
    .font(.caption)
    .padding(.horizontal, 20)
  }
}

//MARK: - Preview
#Preview {
  SortBarView(isShowHolding: false)
}
