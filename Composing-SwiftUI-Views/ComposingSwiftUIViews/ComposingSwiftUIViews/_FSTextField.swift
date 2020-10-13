//

import SwiftUI

struct _FSTextField: View {
  var placeholder: LocalizedStringKey = ""
  @Binding var text: String
  var borderColor: Color

  var body: some View {
    TextField(
      placeholder,
      text: $text
    )
    .padding(.horizontal, 8)
    .padding(.vertical, 4)
    .background(
      RoundedRectangle(cornerRadius: 8, style: .continuous)
        .strokeBorder(borderColor)
    )
  }
}

struct _FSTextField_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      _FSTextField(placeholder: "Placeholder", text: .constant(""), borderColor: .red)
      _FSTextField(placeholder: "Placeholder", text: .constant(""), borderColor: .green)
    }
    .padding()
    .previewLayout(.sizeThatFits)
  }
}
