//
//  HomeView.swift
//  Remider
//
//  Created by Niceplanet T.I on 19/06/25.
//

import Foundation
import UIKit

class HomeView: UIView {
    init(){
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(){
        addSubview(topo)
        setupConstraints()
    }
    
    private let topo: UIView = {
        let viewTopo = UIView()
        viewTopo.backgroundColor = .red
        viewTopo.translatesAutoresizingMaskIntoConstraints = false
        return viewTopo
    }()
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            topo.topAnchor.constraint(equalTo: self.topAnchor, constant: 50),
            topo.heightAnchor.constraint(equalToConstant: 50),
            topo.widthAnchor.constraint(equalToConstant: 50)
        ])
    }
}
