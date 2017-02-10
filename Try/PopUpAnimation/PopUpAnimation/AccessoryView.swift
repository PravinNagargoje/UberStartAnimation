//
//  AccessoryView.swift
//  PopUpAnimation
//
//  Created by Mac on 10/02/17.
//  Copyright © 2017 Mac. All rights reserved.
//
import UIKit

class AccessoryView: UIView {
    
    
    var nextButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.clear
        self.frame = CGRect(x: 0, y: 0, width: 100, height: 50)
        self.addSubview(self.nextButton)

        setupNextButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupNextButton() {
        self.nextButton.setTitle("Done", for: .normal)
        self.nextButton.setTitleColor(UIColor.gray, for: .normal)
        self.nextButton.titleLabel?.font = UIFont(name: "Bold", size: 16)
        self.addSubview(self.nextButton)
        
        self.nextButton.translatesAutoresizingMaskIntoConstraints = false
        let constraints: [NSLayoutConstraint] = [
            self.nextButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            self.nextButton.topAnchor.constraint(equalTo: self.topAnchor),
            self.nextButton.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
