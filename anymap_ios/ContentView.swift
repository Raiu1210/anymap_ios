//
//  ContentView.swift
//  anymap_ios
//
//  Created by raiu on 2020/04/29.
//  Copyright © 2020 Ryu Ishibashi. All rights reserved.
//

import SwiftUI
import MapKit

struct ContentView: View {
    var showModal = false
    
    var body: some View {
        ZStack {
            MainView()
                .addPartialSheet()
            
            if showModal {
                BottomSheet(isOpen: .constant(true), maxHeight: 300) {
                    Rectangle().fill()
                }.edgesIgnoringSafeArea(.all)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
