//
//  MainTabView.swift
//  anymap_ios
//
//  Created by raiu on 2020/05/02.
//  Copyright © 2020 Ryu Ishibashi. All rights reserved.
//

import SwiftUI
import MapKit

struct MainTabView: View {
    @ObservedObject var api = API()
    
    var body: some View {
        TabView {
            Map(api: self.api)
                .tabItem {
                    Image(systemName: "house")
            }.onAppear {
                print("Data Update")
                self.api.get_restroom_list()
            }
            Text("Search friend")
                .tabItem {
                    Image(systemName: "magnifyingglass")
                }
            
        }
        .font(.title)
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
