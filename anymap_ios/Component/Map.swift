//
//  Map.swift
//  anymap_ios
//
//  Created by raiu on 2020/04/29.
//  Copyright © 2020 Ryu Ishibashi. All rights reserved.
//

import SwiftUI
import MapKit
import CoreLocation

struct Map: UIViewRepresentable {
    let api: API
    let map = MKMapView()
    

    func makeCoordinator() -> Map.Coordinator {
        Coordinator(parent1: self)
    }
    
    
    func makeUIView(context: Context) -> MKMapView {
        self.api.sayHello()
        
        let manager = CLLocationManager()
        
        manager.delegate = context.coordinator
        manager.requestAlwaysAuthorization()
        manager.activityType = .automotiveNavigation
        manager.desiredAccuracy = kCLLocationAccuracyKilometer
        manager.distanceFilter = 10.0
        manager.startUpdatingLocation()
        
        map.showsUserLocation = true
        
        
        
        return map
    }
    
    func updateUIView(_ view: MKMapView, context: Context) {
        let annotation = MKPointAnnotation()
        let location = CLLocationCoordinate2D(latitude: 33.564673, longitude: 130.417230)
        annotation.coordinate = location
        annotation.title = "Big Ben"
        annotation.subtitle = "London"
        view.addAnnotation(annotation)
    }
    
    
    class Coordinator : NSObject, CLLocationManagerDelegate {
        var parent : Map
        init(parent1:Map) {
            parent = parent1
        }
        
        func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
            if status == .denied {
                print("denied")
            } else if status == .authorizedWhenInUse {
                print("authorizedWhenInUse")
            } else if status == .authorizedAlways {
                print("authorizedAlways")
            }
        }
        
        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            let location = locations.last
            
            let georeader = CLGeocoder()
            georeader.reverseGeocodeLocation(location!) { (places, err) in
                
                if err != nil {
                    print((err?.localizedDescription)!)
                    return
                }
                
                let region = MKCoordinateRegion(center: location!.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
                self.parent.map.region = region
            }
        }
    }
}

//struct Map_Previews: PreviewProvider {
//    static var previews: some View {
//        Map()
//    }
//}
