import SwiftUI

struct ChartView: View {
  //MARK: - Properties
  let data: [Double]
  let maxY: Double
  let minY: Double
  let lineColor: Color
  
  @State private var percentage: CGFloat = 0
  
  init(coin: CoinModel) {
    data = coin.sparklineIn7D?.price ?? []
    maxY = data.max() ?? 0
    minY = data.min() ?? 0
    
    let priceChange = (data.last ?? 0) - (data.first ?? 0)
    lineColor = priceChange > 0 ? .green : .red
  }
  
  //MARK: - Body
  var body: some View {
    HStack(spacing: 12) {
      chartText
      chartView
        .background(chartBg)
    }
    .frame(height: 200)
    .onAppear {
      DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
        withAnimation(.linear(duration: 2)) {
          percentage = 1
        }
      }
    }
  }
}

//MARK: - Extension View
extension ChartView {
  private var chartView: some View {
    GeometryReader { geometry in
      Path { path in
        for index in data.indices {
          let xPos = geometry.size.width / CGFloat(data.count) * CGFloat(index + 1)
          let yAxis = maxY - minY
          let yPos = (1 - CGFloat((data[index] - minY) / yAxis)) * geometry.size.height
          
          if index == 0 {
            path.move(to: CGPoint(x: xPos, y: yPos))
          }
          path.addLine(to: CGPoint(x: xPos, y: yPos))
        }
      }
      .trim(from: 0, to: percentage)
      .stroke(lineColor, style: StrokeStyle(lineWidth: 3, lineCap: .round, lineJoin: .round))
      .shadow(color: lineColor.opacity(0.4), radius: 10, x: 0, y: 10)
      .shadow(color: lineColor.opacity(0.1), radius: 10, x: 0, y: 40)
    }
  }
  
  private var chartBg: some View {
    VStack {
      Divider()
      Spacer()
      Divider()
      Spacer()
      Divider()
    }
  }
  
  private var chartText: some View {
    VStack(alignment: .leading) {
      Text(maxY.formattedWithAbbreviations())
      Spacer()
      Text(((maxY + minY) / 2).formattedWithAbbreviations())
      Spacer()
      Text(minY.formattedWithAbbreviations())
    }
    .foregroundStyle(.gray)
    .font(.caption2)
  }
}


//MARK: - Preview
#Preview {
  ChartView(coin: DeveloperPreview.instance.coin)
}
