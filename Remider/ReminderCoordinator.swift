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
    
    //MARK: - init
    public init(){
    }
    
    //MARK: - startFlow
    func start() -> UINavigationController? {
        let startViewController = SplashViewController(flowDelegate: self)
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

//MARK: - Splash
extension ReminderCoordinator: SplashFlowDelegate {
    func openLoginBottomSheet(){
        let loginBottomSheet = LoginBottomSheetViewController(flowDelegate: self)
        loginBottomSheet.modalPresentationStyle = .overCurrentContext
        loginBottomSheet.modalTransitionStyle = .crossDissolve
        navigationController?.present(loginBottomSheet, animated: false, completion: {
            loginBottomSheet.animateShow()
        })
    }
}
