//
//  ReminderCoordinator.swift
//  Remider
//
//  Created by Murilo Alves on 13/05/25.
//

import Foundation
import UIKit

class ReminderCoordinator {
    //MARK: - Properties
    private var navigationController: UINavigationController?
    
    //MARK: - Splash
    
    //MARK: - init
    public init(){
    }
    
    //MARK: - startFlow
    func start() -> UINavigationController? {
        let startViewController = SplashViewController()
        self.navigationController = UINavigationController(rootViewController: startViewController)
        return navigationController
    }
}

//MARK: - Login

extension ReminderCoordinator: LoginBottomSheetFlowDelegate{
    func navigateToHome() {
        let viewController = UIViewController()
        viewController.view.backgroundColor = .red
        
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}
