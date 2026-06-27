//
//  ReminderCoordinator.swift
//  Remider
//
//  Created by Murilo Alves on 13/05/25.
//

import Foundation
import UIKit

class ReminderCoordinator: HomeFlowDelegate {
    //MARK: - Properties
    private var navigationController: UINavigationController?
    private let viewControllerFactory: ViewControllersFactoryProtocol
    
    //MARK: - init
    public init(){
        self.viewControllerFactory = ViewControllersFactory()
    }
    
    //MARK: - startFlow
    func start() -> UINavigationController? {
        let startViewController = viewControllerFactory.makeSplashViewController(flowDelegate: self)
        self.navigationController = UINavigationController(rootViewController: startViewController)
        return navigationController
    }
    
    func logout() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func navigateToRecipes() {
        let recipesViewController = viewControllerFactory.makeRecipesViewController()
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.pushViewController(recipesViewController, animated: true)
    }
    
    func navigateToMyRecipes() {
        let myRecipesViewController = viewControllerFactory.makeMyRecipesViewController(flowDelegate: self)
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.pushViewController(myRecipesViewController, animated: true)
    }

}

//MARK: - Login
extension ReminderCoordinator: LoginBottomSheetFlowDelegate{
    func navigateToHome() {
        self.navigationController?.dismiss(animated: false)
        let viewController = viewControllerFactory.makeHomeViewController(flowDelegate: self)
        
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}

//MARK: - Splash
extension ReminderCoordinator: SplashFlowDelegate {
    func openLoginBottomSheet(){
        let loginBottomSheet = viewControllerFactory.makeLoginBottomSheetViewController(flowDelegate: self)
        loginBottomSheet.modalPresentationStyle = .overCurrentContext
        loginBottomSheet.modalTransitionStyle = .crossDissolve
        navigationController?.present(loginBottomSheet, animated: false, completion: {
            loginBottomSheet.animateShow()
        })
    }
    func navigateToHomeUserSaved() {
        self.navigationController?.dismiss(animated: false)
        let viewController = viewControllerFactory.makeHomeViewController(flowDelegate: self)
        
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}

extension ReminderCoordinator: MyReceiptsFlowDelegate {
    func goToNewRecipes() {
        self.navigateToRecipes()
    }
    
    func popScreen() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func goToNewReceipt() {
        self.navigationController?.popViewController(animated: true)
    }
}
