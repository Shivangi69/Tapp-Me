//
//  ViewController.swift
//  GoogleMapPolyLine
//
//  Created by Enamul Haque on 11/30/19.
//  Copyright © 2019 HQUTEIT. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces

class ViewController: UIViewController {
    
    @IBOutlet weak var mapView: GMSMapView!    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let camera = GMSCameraPosition.camera(withLatitude: 37.4, longitude:-122.0, zoom: 10)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        mapView.isMyLocationEnabled = true
        //mapView.myLocationEnabled = true
        mapView.settings.myLocationButton = true;
        self.view = mapView
       
        // Creates a marker in the center of the map.
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: 37.36, longitude: -122.0)
        marker.title = "Bangladesh"
        //marker.snippet = "Malaysia"
        marker.map = mapView
        
        // Create a rectangular path
        let rect = GMSMutablePath()
        rect.add(CLLocationCoordinate2D(latitude: 37.36, longitude: -122.0))
        rect.add(CLLocationCoordinate2D(latitude: 37.45, longitude: -122.0))
        rect.add(CLLocationCoordinate2D(latitude: 37.45, longitude: -122.2))
        rect.add(CLLocationCoordinate2D(latitude: 37.36, longitude: -122.2))
        
        // Create the polygon, and assign it to the map.
        let polygon = GMSPolygon(path: rect)
        polygon.fillColor = UIColor(red: 0.25, green: 0, blue: 0, alpha: 0.05);
        polygon.strokeColor = UIColor.init(hue: 210, saturation: 88, brightness: 84, alpha: 1)
        //polygon.strokeColor = .black
        polygon.strokeWidth = 2
        polygon.map = mapView
       
    }
    
}





