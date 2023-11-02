//
//  CGTextField.swift
//  iFace
//
//  Created by Davron Abdukhakimov on 01/11/23.
//

import UIKit

class CTextField: UITextField {
    let padding = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
    init(placeHolder:String) {
        super.init(frame: .zero)
        self.placeholder = placeHolder
        font = .systemFont(ofSize: 18,weight: .semibold)
        textAlignment = .left
        layer.cornerRadius = 16
        layer.borderWidth = 2
        layer.borderColor = UIColor(named: "ButtonColor")?.cgColor
        clipsToBounds = true
        bounds.inset(by: padding)
        clearButtonMode = .never
        translatesAutoresizingMaskIntoConstraints = false
    }
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
