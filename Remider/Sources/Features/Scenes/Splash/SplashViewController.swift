//
//  SplashViewController.swift
//  Remider
//
//  Created by Murilo Alves on 27/03/25.
//

import Foundation
import UIKit

class SplashViewController: UIViewController {
    let contentView: SplashView
    public weak var flowDelegate: SplashFlowDelegate?
    
    init(contentView: SplashView, 
         flowDelegate: SplashFlowDelegate? = nil) {
        self.contentView = contentView
        self.flowDelegate = flowDelegate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startBreathingAnimation()
//        decideNavigationFlow()
        setupUI()
    }
    
    private func setupUI(){
        self.view.addSubview(contentView)
        self.navigationController?.navigationBar.isHidden = true
        self.view.backgroundColor = Colors.redBase
        setupContentViewToBounds(contentView: contentView)
        setupGesture()
    }
    
    
    private func decideNavigationFlow(){
        if let user = UserDefaultManager.loadUser(), user.isUserSaved{
            flowDelegate?.navigateToHomeUserSaved()
        } else {
            showLoginBottomSheet()
        }
    }
    
    private func setupGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(showLoginBottomSheet))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    @objc
    private func showLoginBottomSheet () {
        self.flowDelegate?.openLoginBottomSheet()
    }
}


//MARK: - Animantions
extension SplashViewController {
    private func startBreathingAnimation(){
        UIView.animate(withDuration: 0.8,
                       delay: 0.0,
                       animations: {
            self.contentView.logoImageView.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        }, completion: {_ in
            self.decideNavigationFlow()
        })
    }
}
