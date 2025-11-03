//
//  CommerceDetailViewController.swift
//  Waylet_App
//
//  Created by Alex Arce Leon on 2/11/25.
//

import UIKit
import MapKit

class CommerceDetailViewController: UIViewController {

    var commerce: Commerce?
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = commerce?.name
        
        showCommerceLocation()
    }

    private func showCommerceLocation() {
        guard let location = commerce?.location else { return }
        
        let coordinates = CLLocationCoordinate2D(latitude: location[1], longitude: location[0])

        let region = MKCoordinateRegion(
            center: coordinates,
            latitudinalMeters: 1000,
            longitudinalMeters: 1000
        )
        mapView.setRegion(region, animated: false)

        let marker = MKPointAnnotation()
        marker.coordinate = coordinates
        marker.title = commerce?.name
        mapView.addAnnotation(marker)
    }
}

