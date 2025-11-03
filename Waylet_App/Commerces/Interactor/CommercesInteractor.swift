//
//  CommercesInteractor.swift
//  Waylet_App
//
//  Created by Alex Arce Leon on 29/10/25.
//

import Foundation
import CoreLocation

protocol CommercesInteractorProtocol {
    func fetchCommerces() async throws -> [Commerce]
    func getUserLocation()
}

class CommercesInteractor: NSObject, CommercesInteractorProtocol{
    
    weak var presenter: CommercesPresenterProtocol?
    
    private let locationManager = CLLocationManager()
    
    func getUserLocation() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func fetchCommerces() async throws -> [Commerce] {
        guard let url = URL(string: "https://waylet-web-export.s3.eu-west-1.amazonaws.com/commerces.json") else { throw URLError(.badURL) }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode != 200 {
            throw URLError(.badServerResponse)
        }
        
        do {
            let commerces = try JSONDecoder().decode([Commerce].self, from: data)
            return commerces
        } catch {
            throw error
        }
    }
}

extension CommercesInteractor: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        print("Ubicación actual: \(location.coordinate.latitude), \(location.coordinate.longitude)")
        
        presenter?.setUserLocation(userLocation: location)
        locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error al obtener ubicación: \(error.localizedDescription)")
    }
    
}
