//
//  SplashView.swift
//  Remider
//
//  Created by Murilo Alves on 27/03/25.
//

import Foundation
import UIKit

class SplashView: UIView {
    
    init(){
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let logoImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "Logo")
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let titleLogoLabel: UILabel = {
        let label = UILabel()
        label.text = "Remind"
        label.font = UIFont.boldSystemFont(ofSize: 42)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    private func setupUI(){

        self.addSubview(logoImageView)
        self.addSubview(titleLogoLabel)
        
        setupConstraints()
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            
            titleLogoLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: Metrics.medium),
            titleLogoLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -Metrics.huge),
            
            logoImageView.trailingAnchor.constraint(equalTo: titleLogoLabel.leadingAnchor, constant: -Metrics.tiny),
            logoImageView.bottomAnchor.constraint(equalTo: titleLogoLabel.bottomAnchor),
            
            
        ])
    }
}
