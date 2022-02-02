//
//  BaseXibView.swift
//  MarvelHeroes
//
//  Created by Humberto C Trujano Chavez on 1/2/22.
//

import UIKit

class BaseXibView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    func commonInit(){
        
        let xibName = swiftXibName()
        
        if let xibView = Bundle(for: type(of: self)).loadNibNamed(xibName, owner: self, options: nil)?[0] as? UIView {

            xibView.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(xibView)
            
            NSLayoutConstraint.activate([
                xibView.topAnchor.constraint(equalTo: self.topAnchor),
                xibView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
                xibView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
                xibView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            ])
        }
    }
    
    func swiftXibName() -> String {
        let className = NSStringFromClass(type(of: self)) as String
        if let indexPoint = className.range(of: ".", options: .backwards)?.lowerBound {
            let index = className.index(after: indexPoint)
            let xibName = className.suffix(from: index)
            return String(xibName)
        }else{
            return ""
        }
    }
}
