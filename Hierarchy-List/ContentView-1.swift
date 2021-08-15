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
  let data: [FileItem] = .spmData

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
      if let subChildren = child[keyPath: children] {
        DisclosureGroup(content: {
          RecursiveView(data: subChildren, children: children, rowContent: rowContent)
        }, label: {
          rowContent(child)
        })
      } else {
        rowContent(child)
      }
    }
  }
}