import SwiftUI

struct CryptoStatsView: View {
  var barData: Bool
  
    var body: some View {
      if barData {
        HStack(alignment: .top) {
          VStack(spacing: 4) {
            Text("Market Cap")
              .font(.caption)
              .foregroundStyle(.secondary)
            
            Text("$1.35Tr")
              .font(.headline)
            
            HStack {
              Image(systemName: "arrowtriangle.down.fill")
              Text("-16.08%")
            }
            .font(.caption)
            .foregroundStyle(.red)
          }
          .frame(maxWidth: 117)
          VStack(spacing: 4) {
            Text("24h value")
              .font(.caption)
              .foregroundStyle(.secondary)
            
            Text("$262.24Bn")
              .font(.headline)
          }
          .frame(maxWidth: 117)
          VStack(spacing: 4) {
            Text("BTC Dominance")
              .font(.caption)
              .foregroundStyle(.secondary)
            
            Text("45.21%")
              .font(.headline)
          }
          .frame(maxWidth: 117)
        }
        .padding(.horizontal, 20)
      } else {
        HStack(alignment: .top) {
          VStack(spacing: 4) {
            Text("24h value")
              .font(.caption)
              .foregroundStyle(.secondary)
            
            Text("$262.24Bn")
              .font(.headline)
          }
          .frame(maxWidth: 117)
          VStack(spacing: 4) {
            Text("BTC Dominance")
              .font(.caption)
              .foregroundStyle(.secondary)
            
            Text("$45.21%")
              .font(.headline)
          }
          .frame(maxWidth: 117)
          VStack(spacing: 4) {
            Text("Portfolio Value")
              .font(.caption)
              .foregroundStyle(.secondary)
            
            Text("42,265.45")
              .font(.headline)
            
            HStack {
              Image(systemName: "arrowtriangle.down.fill")
              Text("-14.90%")
            }
            .font(.caption)
            .foregroundStyle(.red)
          }
          .frame(maxWidth: 117)
        }
        .padding(.horizontal, 20)
      }
    }
}

#Preview {
  CryptoStatsView(barData: true)
}
