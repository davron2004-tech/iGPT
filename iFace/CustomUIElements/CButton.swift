//
//  CGButton.swift
//  iFace
//
//  Created by Davron Abdukhakimov on 01/11/23.
//

import UIKit

class CButton: UIButton {
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(title:String) {
        super.init(frame: .zero)
        setTitle(title, for: .normal)
        titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
        layer.cornerRadius = 8
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor(named: "ButtonColor")
        setTitleColor(.white, for: .normal)
        
    }
    
    
    
}
