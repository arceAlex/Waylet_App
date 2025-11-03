//
//  CommerceDetailRouter.swift
//  Waylet_App
//
//  Created by Alex Arce Leon on 2/11/25.
//

import Foundation
import UIKit


class CommerceDetailRouter {
    static func createModule(with commerce: Commerce) -> UIViewController {
        let view = CommerceDetailViewController()
        view.commerce = commerce
        
        return view
    }
}
