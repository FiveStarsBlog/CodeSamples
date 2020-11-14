//

import SwiftUI

class ContentViewModel: ObservableObject {

  @Published var originalItems = [
    "Here’s", "to", "the", "crazy", "ones", "the", "misfits", "the", "rebels", "the", "troublemakers", "the", "round", "pegs", "in", "the", "square", "holes", "the", "ones", "who", "see", "things", "differently", "they’re", "not", "fond", "of", "rules", "You", "can", "quote", "them", "disagree", "with", "them", "glorify", "or", "vilify", "them", "but", "the", "only", "thing", "you", "can’t", "do", "is", "ignore", "them", "because", "they", "change", "things", "they", "push", "the", "human", "race", "forward", "and", "while", "some", "may", "see", "them", "as", "the", "crazy", "ones", "we", "see", "genius", "because", "the", "ones", "who", "are", "crazy", "enough", "to", "think", "that", "they", "can", "change", "the", "world", "are", "the", "ones", "who", "do"
  ]

  @Published var spacing: CGFloat = 8
  @Published var wordCount: Int = 5

  var words: [String] {
    Array(originalItems.prefix(wordCount))
  }
}

struct ContentView: View {
  @StateObject var model = ContentViewModel()

  var body: some View {
    VStack {
      ReadjustingStackView(data: model.words, spacing: model.spacing) { item in
        Text(verbatim: item)
          .padding(8)
          .background(
            RoundedRectangle(cornerRadius: 8)
              .fill(Color.gray.opacity(0.2))
           )
      }
//      .border(Color.black)
      .padding(.horizontal)
    }
    .frame(maxHeight: .infinity)
    .overlay(Settings(model: model), alignment: .bottom)
  }
}

struct Settings: View {
  @ObservedObject var model: ContentViewModel

  var body: some View {
    VStack {
      Stepper(value: $model.wordCount, in: 0...model.originalItems.count) {
        Text("\(model.wordCount) words")
      }

      HStack {
        Text("Spacing")
        Slider(value: $model.spacing, in: 0...40) { Text("") }
      }

      Button {
        model.originalItems.shuffle()
      } label: {
        Text("Shuffle")
      }
    }
    .padding()
    .background(Color(UIColor.systemBackground))
    .clipShape(RoundedRectangle(cornerRadius: 20))
    .overlay(
         RoundedRectangle(cornerRadius: 20)
             .stroke(Color.primary, lineWidth: 4)
     )
    .padding()
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
