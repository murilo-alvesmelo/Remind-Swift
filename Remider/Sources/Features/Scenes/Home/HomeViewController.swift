//
//  HomeViewController.swift
//  Remider
//
//  Created by Niceplanet T.I on 19/06/25.
//

import Foundation
import UIKit

class HomeViewController: UIViewController {
    let contentView: HomeView
    public weak var flowDelagate: HomeFlowDelegate?
    
    init(contentView: HomeView,
         flowDelagate: HomeFlowDelegate? = nil) {
        self.contentView = contentView
        self.flowDelagate = flowDelagate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupNavigationBar()
    }
    
    private func setupNavigationBar(){
        self.navigationController?.navigationBar.isHidden = false
        self.navigationItem.hidesBackButton = true
        let logoutButton = UIBarButtonItem(image: UIImage(named: "log-out"),
                                           style: .plain,
                                           target: self,
                                           action: #selector(logoutAction))
        logoutButton.tintColor = Colors.redBase
        navigationItem.rightBarButtonItem = logoutButton
    }
    
    private func setupUI(){
        self.view.addSubview(contentView)
        setupConstraints()
    }
    
    private func setupConstraints(){
        setupContentViewToBounds(contentView: contentView)
    }
    
    @objc
    private func logoutAction(){
        print("Função sayHello foi chamada!")
    }
}
