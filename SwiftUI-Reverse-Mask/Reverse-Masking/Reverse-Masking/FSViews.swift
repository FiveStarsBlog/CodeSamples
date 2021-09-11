import SwiftUI

struct FSView1: View {
  var body: some View {
    HStack {
      Color.yellow
        .frame(width: 200, height: 200)
        .mask {
          Star()
        }
        .border(.red)

      Color.yellow
        .frame(width: 200, height: 200)
        .reverseMask {
          Star()
        }
        .border(.red)
    }
    .padding()
  }
}

struct FSView2: View {
  var body: some View {
    HStack {
      Color.yellow
        .frame(width: 200, height: 200)
        .mask {
          Text("MASK")
            .font(.system(size: 60).weight(.black))
        }
        .border(.red)

      Color.yellow
        .frame(width: 200, height: 200)
        .reverseMask {
          Text("MASK")
            .font(.system(size: 60).weight(.black))
        }
        .border(.red)
    }
    .padding()
  }
}

struct FSView3: View {
  var body: some View {
    HStack {
      Color.yellow
        .frame(width: 200, height: 200)
        .mask {
          LinearGradient(
            colors: [.clear, .black],
            startPoint: .leading, endPoint: .trailing
          )
        }
        .border(.red)
      
      Color.yellow
        .frame(width: 200, height: 200)
        .reverseMask {
          LinearGradient(
            colors: [.clear, .black],
            startPoint: .leading, endPoint: .trailing
          )
        }
        .border(.red)
    }
    .padding()
  }
}

struct FSView4: View {
  var body: some View {
    HStack {
      ZStack {
        Rectangle() // destination
        Circle()    // source
          .blendMode(.destinationOut)
      }
      .compositingGroup()
      .frame(width: 200, height: 200)
      .border(.red)

      ZStack {
        Circle()    // destination
        Rectangle() // source
          .blendMode(.destinationOut)
      }
      .compositingGroup()
      .frame(width: 200, height: 200)
      .border(.red)
    }
    .padding()
  }
}

struct FSView5: View {
  var body: some View {
    HStack {
      ZStack {
        LinearGradient(
          colors: [.clear, .black],
          startPoint: .leading, endPoint: .trailing
        )           // destination
        Circle()    // source
          .blendMode(.destinationOut)
      }
      .compositingGroup()
      .frame(width: 200, height: 200)
      .border(.red)

      ZStack {
        Circle()    // destination
        LinearGradient(
          colors: [.clear, .black],
          startPoint: .leading, endPoint: .trailing
        )           // source
        .blendMode(.destinationOut)
      }
      .compositingGroup()
      .frame(width: 200, height: 200)
      .border(.red)
    }
    .padding()
  }
}
