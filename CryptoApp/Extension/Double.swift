import Foundation

extension Double {
  private var currencyFormatter2: NumberFormatter {
    let formatter = NumberFormatter()
    formatter.usesGroupingSeparator = true
    formatter.numberStyle = .currency
    formatter.currencyCode = "USD"
    formatter.currencySymbol = "$"
    formatter.locale = Locale(identifier: "en_US")
    formatter.minimumFractionDigits = 2
    formatter.maximumFractionDigits = 2
    return formatter
  }
  
  func asCurrencyDecimals2() -> String {
    return currencyFormatter2.string(from: NSNumber(value: self)) ?? ""
  }
  
  private var currencyFormatter6: NumberFormatter {
    let formatter = NumberFormatter()
    formatter.usesGroupingSeparator = true
    formatter.numberStyle = .currency
    formatter.currencyCode = "USD"
    formatter.currencySymbol = "$"
    formatter.locale = Locale(identifier: "en_US")
    formatter.maximumFractionDigits = 2
    formatter.maximumFractionDigits = 6
    return formatter
  }
  
  func asCurrencyDecimals6() -> String {
    return currencyFormatter6.string(from: NSNumber(value: self)) ?? ""
  }
  
  func asNumberString() -> String {
    return String(format: "%.2f", self)
  }
  
  func asPercentString() -> String {
    return asNumberString() + "%"
  }
}
