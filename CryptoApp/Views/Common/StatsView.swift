import SwiftUI

struct StatsView: View {
  //MARK: - Properties
  let stat: StatsModel
  
  //MARK: - Body
  var body: some View {
    VStack(spacing: 4) {
      Text(stat.title)
        .foregroundStyle(.secondary)
      Text(stat.value)
        .font(.headline)
      HStack(spacing: 4) {
        Image(systemName: "triangle.fill")
          .rotationEffect(.degrees((stat.percent ?? 0) >= 0 ? 0 : 180))
        Text(stat.percent?.asPercentString() ?? "")
      }
      .foregroundStyle((stat.percent ?? 0) >= 0 ? .green : .red)
      .opacity(stat.percent == nil ? 0 : 1)
    }
    .font(.caption)
  }
}

#Preview {
  StatsView(stat: StatsModel(title: "Market Cap", value: "$1.35Tr", percent: -16.08))
}
