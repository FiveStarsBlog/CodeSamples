import SwiftUI

struct FSView1: View {
  private let alignments: [Alignment] = [
    .center, .leading, .trailing, .top, .bottom, .topLeading, .topTrailing, .bottomLeading, .bottomTrailing
  ]
  @State var alignment: Alignment = .center

  var body: some View {
    VStack {
      Color.yellow
        .frame(width: 200, height: 200)
        .mask(alignment: alignment) {
          Rectangle()
            .frame(width: 60, height: 60)
        }
        .border(.red)

      Button("Random alignment") {
        withAnimation {
          alignment = alignments.filter { $0 != alignment } .randomElement()!
        }
      }
    }
  }
}

struct FSView2: View {
  var body: some View {
    Color.yellow
      .frame(width: 200, height: 200)
      .mask {
        Text("MASK")
          .fontWeight(.black)
          .font(.system(size: 60))
      }
      .border(Color.red)
  }
}

struct FSView3: View {
  var body: some View {
    Color.yellow
      .frame(width: 300, height: 300)
      .frame(width: 200, height: 200)
      .mask {
        Text("MASK")
          .fontWeight(.black)
          .font(.system(size: 80))
          .fixedSize() // 👈🏻 Ignores the proposed 200x200 points size
      }
      .border(Color.red)
  }
}

struct FSView4: View {
  var body: some View {
    Color.yellow
      .frame(width: 200, height: 200)
      .mask {
        LinearGradient(colors: [.clear, .black, .clear], startPoint: .leading, endPoint: .trailing)
      }
      .border(Color.red)
  }
}

struct FSView5: View {
  var body: some View {
    ScrollView {
      ForEach(1..<30) { _ in
        Text("Five Stars")
          .font(.largeTitle)
      }
      .frame(maxWidth: .infinity)
    }
    .safeAreaInset(edge: .bottom) {
      Button { } label: {
        Text("Continue")
          .frame(maxWidth: .infinity)
      }
      .buttonStyle(.borderedProminent)
      .controlSize(.large)
      .padding(.horizontal)
    }
  }
}

struct FSView6: View {
  var body: some View {
    ScrollView {
      ForEach(1..<30) { _ in
        Text("Five Stars")
          .font(.largeTitle)
      }
      .frame(maxWidth: .infinity)
    }
    .safeAreaInset(edge: .bottom) {
      Button { } label: {
        Text("Continue")
          .frame(maxWidth: .infinity)
      }
      .buttonStyle(.borderedProminent)
      .controlSize(.large)
      .padding(.horizontal)
      .background {
        Color(uiColor: .systemBackground)
          .mask(alignment: .top) {
            VStack(spacing: 0) {
              LinearGradient(
                stops: [
                  Gradient.Stop(color: .clear, location: .zero),
                  Gradient.Stop(color: .black, location: 1.0)
                ],
                startPoint: .top,
                endPoint: .bottom
              )
              .frame(height: 32)
              Color.black
            }
          }
          .padding(.top, -32)
          .ignoresSafeArea(.all, edges: .bottom)
      }
    }
  }
}

struct FSView7: View {
  var body: some View {
    ScrollView {
      ForEach(1..<30) { _ in
        Text("Five Stars")
          .font(.largeTitle)
      }
      .frame(maxWidth: .infinity)
    }
    .safeAreaInset(edge: .bottom) {
      Button { } label: {
        Text("Continue")
          .frame(maxWidth: .infinity)
      }
      .buttonStyle(.borderedProminent)
      .controlSize(.large)
      .padding(.horizontal)
      .background {
        Color.clear
          .background(.ultraThinMaterial)
          .mask(alignment: .top) {
            VStack(spacing: 0) {
              LinearGradient(
                stops: [
                  Gradient.Stop(color: .clear, location: .zero),
                  Gradient.Stop(color: .black, location: 1.0)
                ],
                startPoint: .top,
                endPoint: .bottom
              )
              .frame(height: 32)
              Color.black
            }
          }
          .padding(.top, -32)
          .ignoresSafeArea(.all, edges: .bottom)
      }
    }
  }
}
