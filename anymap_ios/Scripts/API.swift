//
//  API.swift
//  anymap_ios
//
//  Created by raiu on 2020/04/29.
//  Copyright © 2020 Ryu Ishibashi. All rights reserved.
//

import Foundation


class API : ObservableObject {
    let server_url = "http://zihankimap.work/"
    let encoder = JSONEncoder()
    let decoder = JSONDecoder()
    
    @Published var pin_data:[Restroom_data] = []
    
    init() {
        get_restroom_list()
    }
    
    func get_restroom_list() {
        let semaphore = DispatchSemaphore(value: 0)
        let destination = server_url + "datalist?table_id=2"
        let url = URL(string: destination)!
        
        let session = URLSession.shared
        let request = URLRequest(url: url)
        
//        var recv_obj:[Restroom_data] = []
        
        session.dataTask(with: request) {
            (data, response, error) in if error == nil, let data = data, let _ = response as? HTTPURLResponse {
                
                do {
                    self.pin_data = try! self.decoder.decode([Restroom_data].self, from: data)
                    semaphore.signal()
                } catch {
                    print("Error:\(error)")
                }
                    
                }
            }.resume()
        semaphore.wait()
        
//        return recv_obj
    }
}



struct Restroom_data : Codable {
    var id:String
    var latitude:String
    var longitude:String
    var updated:String
    var memo:String
}
