//
//  CommerceDetailViewController.swift
//  Waylet_App
//
//  Created by Alex Arce Leon on 2/11/25.
//

import UIKit

//class CommerceDetailViewController: UIViewController {
//    
//    var commerce: Commerce?
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        self.title = commerce?.name
//
//        // Do any additional setup after loading the view.
//    }
//
//
//    /*
//    // MARK: - Navigation
//
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destination.
//        // Pass the selected object to the new view controller.
//    }
//    */
//
//}

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

