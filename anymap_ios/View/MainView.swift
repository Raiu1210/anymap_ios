//
//  MainView.swift
//  anymap_ios
//
//  Created by raiu on 2020/05/02.
//  Copyright © 2020 Ryu Ishibashi. All rights reserved.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        NavigationView {
            MainTabView()
            
            .navigationBarTitle(Text("AnyMap"), displayMode: .inline)
            
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
