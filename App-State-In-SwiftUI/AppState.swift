// Gist from https://fivestars.blog/swiftui/app-state.html

import SwiftUI

@main
struct FiveStarsApp: App {
  @StateObject var appStateContainer = AppStateContainer()

  var body: some Scene {
    WindowGroup {
      ContentView()
        .environmentObject(appStateContainer)
        .environmentObject(appStateContainer.tabViewState)
    }
  }
}

enum Tab: Hashable {
  case home
  case settings
}

class TabViewState: ObservableObject {
  @Published var selectedTab: Tab = .home
}

class AppStateContainer: ObservableObject {
  var tabViewState = TabViewState()
}

struct ContentView: View {
  @EnvironmentObject var state: TabViewState

  var body: some View {
    TabView(selection: $state.selectedTab) {
      HomeView()
        .tabItem {
          Label("Home", systemImage: "house.fill")
        }
        .tag(Tab.home)

      SettingsView()
        .tabItem {
          Label("Settings", systemImage: "gear")
        }
        .tag(Tab.settings)
    }
  }
}

struct HomeView: View {
  @EnvironmentObject var container: AppStateContainer

  var body: some View {
    VStack {
      Button("go to settings") {
        container.tabViewState.selectedTab = .settings
      }
      Text("Home")
    }
  }
}

struct SettingsView: View {
  var body: some View {
    Text("Settings")
  }
}