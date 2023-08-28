//
//  SelectVehicle.swift
//  io
//
//  Created by gv on 25/08/2023.
//

import UIKit
import GoogleMaps

final
class SelectVehicle: UIViewController {
    
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var bottomView: UIView!
    
    let coordinate = CLLocationCoordinate2D(latitude: 48.857165, longitude: 2.354613)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Marker
        var locationMarker = GMSMarker(position: coordinate)
        locationMarker.map = mapView
        locationMarker.title = "Paris"
        locationMarker.snippet = "The best place on earth."
        locationMarker.appearAnimation = .pop
        locationMarker.icon = GMSMarker.markerImage(with: UIColor.blue)
        locationMarker.opacity = 0.75
        
        // Camera
        let camera = GMSCameraPosition.camera(withLatitude: 51.5287352, longitude: -0.3817818, zoom: 8)
        mapView.camera = camera
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: 51.5287352, longitude: -0.3817818)
        marker.title = "My marker"
        marker.map = self.mapView
        
        self.mapView.delegate = self
        
        // config view
        bottomView.roundCorners(corners: [.topLeft, .topRight], radius: 10)
    }
}

extension SelectVehicle: GMSMapViewDelegate {
    
}
