import SwiftUI

enum ButtonType {
  case back
  case save
}

struct CustomButton: View {
  //MARK: - Properties
  let type: ButtonType
  let action: () -> Void
  
  //MARK: - Body
  var body: some View {
    Button(action: action) {
      HStack(spacing: 4) {
        if let image = image {
          Image(systemName: image)
        }
        Text(text)
      }
      .foregroundStyle(color)
    }
  }
  
  private var image: String? {
    switch type {
      case .back: "chevron.left"
      case .save: nil
    }
  }
  
  private var text: String {
    switch type {
      case .back: "Back"
      case .save: "Save"
    }
  }
  
  private var color: Color {
    switch type {
      case .back: .accent
      case .save: .red
    }
  }
}

#Preview {
  CustomButton(type: .back, action: {})
}
