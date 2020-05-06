//
//  MainTabView.swift
//  anymap_ios
//
//  Created by raiu on 2020/05/02.
//  Copyright © 2020 Ryu Ishibashi. All rights reserved.
//

import SwiftUI
import MapKit
import PartialSheet

struct MainTabView: View {
    @ObservedObject var api = API()
    @EnvironmentObject var partialSheetManager: PartialSheetManager
    
    var body: some View {
        TabView {
            MapView()
                .tabItem {
                    Image(systemName: "house")
            }.onAppear {
                print("Data Update")
                self.api.get_restroom_list()
            }
            Button("Hey", action: {
                self.partialSheetManager.showPartialSheet({
                    print("Partial sheet dismissed")
                }) {
//                    Button("Close", action:  {
//                        self.partialSheetManager.closePartialSheet()
//                    })
                    Text("Hey")
                    .frame(height: 200)
                }
            })
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
