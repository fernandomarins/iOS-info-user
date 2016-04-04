//
//  ViewController.swift
//  InfoUser
//
//  Created by Fernando Augusto de Marins on 15/02/16.
//  Copyright © 2016 Fernando Augusto de Marins. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController,
    MKMapViewDelegate,
    CLLocationManagerDelegate {

    @IBOutlet weak var adress: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()

    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        print(locations)
        
        let userLocation: CLLocation = locations[0]
        
        let latitude: CLLocationDegrees = userLocation.coordinate.latitude
        let longitude: CLLocationDegrees = userLocation.coordinate.longitude
        
        let latDelta: CLLocationDegrees = 0.01
        let longDelta: CLLocationDegrees = 0.01
        
        let span: MKCoordinateSpan = MKCoordinateSpanMake(latDelta, longDelta)
        let location: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
        
        let region: MKCoordinateRegion = MKCoordinateRegionMake(location, span)
        
        mapView.setRegion(region, animated: true)
        
        CLGeocoder().reverseGeocodeLocation(userLocation) { (placemarks, error) -> Void in
            if (error != nil) {
                print(error)
            } else {
                let placemark = placemarks?[0]
                let userPlacemark = CLPlacemark(placemark: placemark!)
                
                if let address = userPlacemark.subLocality {
                    self.adress.text = "\(userPlacemark.subLocality!), \(userPlacemark.postalCode!), \(userPlacemark.country!)"
                } else {
                    self.adress.text = "Not found"
                }
            }
        }
        
    }


}

