//
//  ViewControllersFactory.swift
//  Remider
//
//  Created by Murilo Alves on 03/06/25.
//

import Foundation
import UIKit

final class ViewControllersFactory: ViewControllersFactoryProtocol {
    func makeSplashViewController(flowDelegate: SplashFlowDelegate) -> SplashViewController {
        let contentView = SplashView()
        let viewController = SplashViewController(contentView: contentView,
                                                  flowDelegate: flowDelegate)
        return viewController
    }
    func makeLoginBottomSheetViewController(flowDelegate: LoginBottomSheetFlowDelegate) -> LoginBottomSheetViewController {
        let contentView = LoginBottomSheetView()
        let viewController = LoginBottomSheetViewController(contentView: contentView,
                                                            flowDelegate: flowDelegate)
        return viewController
    }
    func makeHomeViewController(flowDelegate: HomeFlowDelegate) -> HomeViewController {
        let contentView = HomeView()
        let viewController = HomeViewController(contentView: contentView,
                                                flowDelagate: flowDelegate)
        
        return viewController
    }
}
