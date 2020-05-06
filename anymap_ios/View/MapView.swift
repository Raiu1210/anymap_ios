//
//  MapView.swift
//  anymap_ios
//
//  Created by raiu on 2020/05/06.
//  Copyright © 2020 Ryu Ishibashi. All rights reserved.
//

import SwiftUI

struct MapView: View {
    @ObservedObject var api = API()
    
    var body: some View {
        ZStack {
            Map(api: self.api)
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
