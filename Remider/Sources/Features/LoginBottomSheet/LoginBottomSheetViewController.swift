//
//  LoginBottomSheetViewController.swift
//  Remider
//
//  Created by Murilo Alves on 01/04/25.
//

import Foundation
import UIKit

class LoginBottomSheetViewController:  UIViewController {
    let loginModel = LoginBottomSheetViewModel()
    let contentView: LoginBottomSheetView
    var handleAreaHeight: CGFloat = 50.0
    public weak var flowDelegate: LoginBottomSheetFlowDelegate?
    
    
    init(contentView: LoginBottomSheetView,
         flowDelegate: LoginBottomSheetFlowDelegate){
        self.contentView = contentView
        self.flowDelegate = flowDelegate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        contentView.delegate = self
        setupUI()
        setupGesture()
        handlePanGesture()
        bindViewModel()
    }
    
    private func setupUI(){
        self.view.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        setupConstraints()
    }
    
    private func setupGesture() {
        //
    }
    
    private func handlePanGesture(){
        //
    }
    
    public func animateShow(completion: (()-> Void)? = nil) {
        self.view.layoutIfNeeded()
        contentView.transform = CGAffineTransform(translationX: 0, y: contentView.frame.height)
        UIView.animate(withDuration: 0.3, animations: {
            self.contentView.transform = .identity
            self.view.layoutIfNeeded()
        }) {_ in
            completion?()
        }
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
        ])
        
        let heightConstraint = contentView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.5).isActive = true
    }
    
    private func bindViewModel(){
        loginModel.succesResult = {[weak self] in
            self?.flowDelegate?.navigateToHome()
            self?.dismiss(animated: false)
        }
    }
}

/* MARK: - SendLoginData */
extension LoginBottomSheetViewController: LoginBottomSheetViewDelegate{
    func sendLoginData(user: String, password: String) {
        loginModel.doAuth(user: user, password: password)
    }
}
