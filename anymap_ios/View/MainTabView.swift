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
//    @State var manager = CLLocationManager()
//    @State var alert = false
    
    var body: some View {
        TabView {
            Map() 
                .tabItem {
                    Image(systemName: "house")
                }
            
            Text("Search friend")
                .tabItem {
                    Image(systemName: "magnifyingglass")
                }
            
            Text("Notification")
                .tabItem{
                    Image(systemName: "bell")
                }
            
            Text("Setting")
                .tabItem {
                    Image(systemName: "gear")
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
