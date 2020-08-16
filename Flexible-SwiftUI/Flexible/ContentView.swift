//

import SwiftUI

class ContentViewModel: ObservableObject {

  @Published var originalItems = [
    "Here’s", "to", "the", "crazy", "ones", "the", "misfits", "the", "rebels", "the", "troublemakers", "the", "round", "pegs", "in", "the", "square", "holes", "the", "ones", "who", "see", "things", "differently", "they’re", "not", "fond", "of", "rules", "You", "can", "quote", "them", "disagree", "with", "them", "glorify", "or", "vilify", "them", "but", "the", "only", "thing", "you", "can’t", "do", "is", "ignore", "them", "because", "they", "change", "things", "they", "push", "the", "human", "race", "forward", "and", "while", "some", "may", "see", "them", "as", "the", "crazy", "ones", "we", "see", "genius", "because", "the", "ones", "who", "are", "crazy", "enough", "to", "think", "that", "they", "can", "change", "the", "world", "are", "the", "ones", "who", "do"
  ]

  @Published var spacing: CGFloat = 8
  @Published var padding: CGFloat = 8
  @Published var wordCount: Int = 75
  @Published var alignmentIndex = 0

  var words: [String] {
    Array(originalItems.prefix(wordCount))
  }

  let alignments: [HorizontalAlignment] = [.leading, .center, .trailing]

  var alignment: HorizontalAlignment {
    alignments[alignmentIndex]
  }
}

struct ContentView: View {
  @StateObject var model = ContentViewModel()

  var body: some View {
    ScrollView {
      FlexibleView(
        data: model.words,
        spacing: model.spacing,
        alignment: model.alignment
      ) { item in
        Text(verbatim: item)
          .padding(8)
          .background(
            RoundedRectangle(cornerRadius: 8)
              .fill(Color.gray.opacity(0.2))
           )
      }
      .padding(.horizontal, model.padding)
    }
    .overlay(Settings(model: model), alignment: .bottom)
  }
}

struct Settings: View {
  @ObservedObject var model: ContentViewModel
  let alignmentName: [String] = ["leading", "center", "trailing"]

  var body: some View {
    VStack {
      Stepper(value: $model.wordCount, in: 0...model.originalItems.count) {
        Text("\(model.wordCount) words")
      }

      HStack {
        Text("Padding")
        Slider(value: $model.padding, in: 0...60) { Text("") }
      }

      HStack {
        Text("Spacing")
        Slider(value: $model.spacing, in: 0...40) { Text("") }
      }

      HStack {
        Text("Alignment")
        Picker("Choose alignment", selection: $model.alignmentIndex) {
          ForEach(0..<model.alignments.count) {
            Text(alignmentName[$0])
          }
        }
        .pickerStyle(SegmentedPickerStyle())
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
