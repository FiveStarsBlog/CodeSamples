// Original article here: https://www.fivestars.blog/code/swiftui-hierarchy-list.html

import SwiftUI

struct FileItem: Identifiable {
  let name: String
  var children: [FileItem]?

  var id: String { name }

  static let spmData: [FileItem] = [
    FileItem(name: ".gitignore"),
    FileItem(name: "Package.swift"),
    FileItem(name: "README.md"),
    FileItem(name: "Sources", children: [
      FileItem(name: "fivestars", children: [
        FileItem(name: "main.swift")
      ]),
    ]),
    FileItem(name: "Tests", children: [
      FileItem(name: "fivestarsTests", children: [
        FileItem(name: "fivestarsTests.swift"),
        FileItem(name: "XCTestManifests.swift"),
      ]),
      FileItem(name: "LinuxMain.swift")
    ])
  ]
}

struct ContentView: View {
  let data: [FileItem] = FileItem.spmData

  var body: some View {
//    List(data, children: \.children, rowContent: { Text($0.name) })
    HierarchyList(data: data, children: \.children, rowContent: { Text($0.name) })
  }
}

public struct HierarchyList<Data, RowContent>: View where Data: RandomAccessCollection, Data.Element: Identifiable, RowContent: View {
  private let recursiveView: RecursiveView<Data, RowContent>

  public init(data: Data, children: KeyPath<Data.Element, Data?>, rowContent: @escaping (Data.Element) -> RowContent) {
    self.recursiveView = RecursiveView(data: data, children: children, rowContent: rowContent)
  }

  public var body: some View {
    List {
      recursiveView
    }
  }
}

private struct RecursiveView<Data, RowContent>: View where Data: RandomAccessCollection, Data.Element: Identifiable, RowContent: View {
  let data: Data
  let children: KeyPath<Data.Element, Data?>
  let rowContent: (Data.Element) -> RowContent

  var body: some View {
    ForEach(data) { child in
      if self.containsSub(child)  {
        FSDisclosureGroup(content: {
          RecursiveView(data: child[keyPath: self.children]!, children: self.children, rowContent: self.rowContent)
          .padding(.leading)
        }, label: {
          self.rowContent(child)
        })
      } else {
        self.rowContent(child)
      }
    }
  }

  func containsSub(_ element: Data.Element) -> Bool {
    element[keyPath: children] != nil
  }
}

struct FSDisclosureGroup<Label, Content>: View where Label: View, Content: View {
  @State var isExpanded: Bool = false
  var content: () -> Content
  var label: () -> Label

  @ViewBuilder
  var body: some View {
    Button(action: { self.isExpanded.toggle() }, label: { label().foregroundColor(.blue) })
    if isExpanded {
      content()
    }
  }
}
