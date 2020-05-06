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
        print(api.annotaions.count)
        view.delegate = context.coordinator
        view.addAnnotations(api.annotaions)
    }
    
    
    class Coordinator : NSObject, CLLocationManagerDelegate, MKMapViewDelegate {
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
        
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            if annotation is MKUserLocation { return nil }
            let CustomAnnotation = annotation as! CustomPointAnnotation
            let annotationView = MKMarkerAnnotationView(annotation: CustomAnnotation, reuseIdentifier: nil)
            
            if(CustomAnnotation.type == "registered") {
                print("Hey")
            }

            return annotationView
        }
        
        func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
            print("Selected ")
            if(view.annotation?.title == "My Location"){
                print("this is my location")
                return
            }
            
            var annotation_subtitle:String = ""
            annotation_subtitle = String((view.annotation?.subtitle ?? "more")!)
            if(annotation_subtitle.suffix(4) == "more") {
                print("this is cluster")
            } else {
//                floatingPanelController.show(animated: true)
//                let type = String((view.annotation as! CustomPointAnnotation).type)
//                let id = String((view.annotation as! CustomPointAnnotation).id)
//                let memo = String((view.annotation as! CustomPointAnnotation).memo)
//                let timestamp = String((view.annotation as! CustomPointAnnotation).timestamp)
                let latitude = String(Double(view.annotation?.coordinate.latitude ?? 0.000000000))
                let longitude = String(Double(view.annotation?.coordinate.longitude ?? 0.00000000))
                print(latitude)
                print(longitude)
//                semiModalViewController.update_SemiModalView(type:type, id:id, latitude:latitude, longitude:longitude, timestamp:timestamp, memo:memo)
            }
            
            print(view.annotation?.title)
            print(view.annotation?.subtitle)
        }
    }
}

//struct Map_Previews: PreviewProvider {
//    static var previews: some View {
//        Map()
//    }
//}
