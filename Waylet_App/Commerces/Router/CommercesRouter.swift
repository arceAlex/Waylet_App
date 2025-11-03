//
//  CommercesRouter.swift
//  Waylet_App
//
//  Created by Alex Arce Leon on 29/10/25.
//

import Foundation
import UIKit

protocol CommercesRouterProtocol {
    func navigateTo(navController: UINavigationController, commerce: Commerce)
}

class CommercesRouter: CommercesRouterProtocol {
    
    func createModule() -> UIViewController {
        let commercesVC = CommercesViewController()
        let interactor = CommercesInteractor()
        let presenter = CommercesPressenter()
        
        interactor.presenter = presenter
        presenter.interactor = interactor
        presenter.view = commercesVC
        presenter.router = self
        commercesVC.presenter = presenter
        
        let navController = UINavigationController(rootViewController: commercesVC)
        return navController
    }
    
    func navigateTo(navController: UINavigationController, commerce: Commerce) {
        let vc = CommerceDetailRouter.createModule(with: commerce)
        navController.pushViewController(vc, animated: true)
    }
}
