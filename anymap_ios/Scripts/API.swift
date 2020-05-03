//
//  API.swift
//  anymap_ios
//
//  Created by raiu on 2020/04/29.
//  Copyright © 2020 Ryu Ishibashi. All rights reserved.
//

import Foundation
import MapKit

class API : ObservableObject {
    let server_url = "http://zihankimap.work/"
    let encoder = JSONEncoder()
    let decoder = JSONDecoder()
    
    @Published var pin_data:[Restroom_data] = []
    @Published var annotaions:[CustomPointAnnotation] = []
    
    init() {
        get_restroom_list()
    }
    
    func sayHello() {
        print("Hello")
    }
    
    func get_restroom_list() {
        pin_data = []
        let semaphore = DispatchSemaphore(value: 0)
        let destination = server_url + "datalist?table_id=2"
        let url = URL(string: destination)!
        
        let session = URLSession.shared
        let request = URLRequest(url: url)
        
        DispatchQueue.main.async {
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
            self.convert_annotaions()
            semaphore.wait()
        }
    }
    
    func convert_annotaions() {
        var temp_annotations: [CustomPointAnnotation] = []
        for i in 0 ..< pin_data.count {
            let lat:CLLocationDegrees = Double(pin_data[i].latitude)!
            let lon:CLLocationDegrees = Double(pin_data[i].longitude)!
            let coordinate: CLLocationCoordinate2D = CLLocationCoordinate2DMake(lat, lon)
            
//            annotation.type      = "registered"
            let title     = pin_data[i].memo
            let timestamp = pin_data[i].updated
            let memo      = pin_data[i].memo
            
            let annotation = CustomPointAnnotation(title: title, subtitle: memo, coordinate: coordinate)
            temp_annotations.append(annotation)
        }
        self.annotaions = temp_annotations
    }
}


class CustomPointAnnotation: NSObject, MKAnnotation {
    let title: String?
    let subtitle: String?
    let coordinate: CLLocationCoordinate2D
    
    init(title: String?, subtitle: String?, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.subtitle = subtitle
        self.coordinate = coordinate
    }
}

//
//var type: String!
//var id: String!
//var timestamp: String!
//var memo: String!
//var pinColor: UIColor = UIColor.blue





struct Restroom_data : Codable {
    var id:String
    var latitude:String
    var longitude:String
    var updated:String
    var memo:String
}
