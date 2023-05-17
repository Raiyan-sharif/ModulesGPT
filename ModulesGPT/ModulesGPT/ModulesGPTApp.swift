//
//  ModulesGPTApp.swift
//  ModulesGPT
//
//  Created by BJIT on 16/5/23.
//

import SwiftUI

@main
struct ModulesGPTApp: App {
    var body: some Scene {
        WindowGroup {
            RootView()
        }
    }
}

struct RootView: View{
    @ObservedObject private var model = AppModel()
    var body: some View{
        TabView{
            ModulesView()
                .tabItem {
                    Image(systemName: "rectangle.stack.fill")
                    Text("Modules")
                }
            SettingsView()
                .tabItem {
                    Image(systemName: "gear")
                    Text("Settings")
                }
        }
        .environmentObject(model)
        .onAppear{
            model.setup()
        }
    }
}

struct RootView_Previews: PreviewProvider{
    static var previews: some View{
        RootView()
    }
}
