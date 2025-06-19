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
    }
    
    private func setupUI(){
        self.view.addSubview(contentView)
        setupContentViewToBounds(contentView: contentView)
        setupConstraints()
    }
    
    private func setupConstraints(){
        
    }
}
