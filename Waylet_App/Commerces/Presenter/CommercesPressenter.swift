//
//  CommercesPressenter.swift
//  Waylet_App
//
//  Created by Alex Arce Leon on 30/10/25.
//

import Foundation
import CoreLocation
import UIKit

protocol CommercesPresenterProtocol: AnyObject {
    func loadCommerces()
    func filterCommerces(category: Category)
    func getUserLocation()
    func calculateUserDistance(commerceLocation: [Double]) -> String
    func setUserLocation(userLocation: CLLocation)
    func sortByDistance(commerces: [Commerce])
    func openCommerceDetail(commerce: Commerce, navController: UINavigationController)
}


class CommercesPressenter: CommercesPresenterProtocol {

    var interactor: CommercesInteractorProtocol?
    var router: CommercesRouterProtocol?
    weak var view: CommercesViewProtocol?
    
    private var allCommerces: [Commerce] = []
    private var userLocation: CLLocation?
    
    func loadCommerces() {
        Task {
            do {
                let commerces = try await interactor?.fetchCommerces() ?? []
                allCommerces = commerces
                await MainActor.run {
                    view?.setCommerces(commerces: commerces)
                    view?.reloadCollection()
                }
                
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func filterCommerces(category: Category) {
        let filteredCommerces = allCommerces.filter { commerce in
            return commerce.category == category
        }
        view?.setCommerces(commerces: filteredCommerces)
        view?.reloadCollection()
    }
    
    func getUserLocation(){
        interactor?.getUserLocation()
    }
    
    func calculateUserDistance(commerceLocation: [Double]) -> String {
        
        let commerceLoc =  CLLocation(latitude: commerceLocation[1], longitude: commerceLocation[0])
        let distance = userLocation?.distance(from: commerceLoc)
        
        if let distance = distance {
            let distanceInKm = distance / 1000
            return String(format: "%.2f km", distanceInKm)
        } else {
            return ""
        }
    }
    
    func setUserLocation(userLocation: CLLocation) {
        self.userLocation = userLocation
        view?.reloadCollection()
    }
    
    func sortByDistance(commerces: [Commerce]) {
        guard let userLocation = userLocation else {
            return
        }
        
        let sortedCommerces = commerces.sorted { commerceA, commerceB in
            guard let locA = commerceA.location, let locB = commerceB.location else {
                return false
            }
            
            let locationA = CLLocation(latitude: locA[1], longitude: locA[0])
            let locationB = CLLocation(latitude: locB[1], longitude: locB[0])
            
            let distanceA = userLocation.distance(from: locationA)
            let distanceB = userLocation.distance(from: locationB)
            
            return distanceA < distanceB
        }
        
        self.view?.setCommerces(commerces: sortedCommerces)
        self.view?.reloadCollection()
        
    }
    
    func openCommerceDetail(commerce: Commerce, navController: UINavigationController) {
        router?.navigateTo(navController: navController, commerce: commerce)
    }
}
