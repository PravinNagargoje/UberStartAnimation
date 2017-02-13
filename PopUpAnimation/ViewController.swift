//
//  ViewController.swift
//  PopUpAnimation
//
//  Created by Mac on 09/02/17.
//  Copyright © 2017 Mac. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    fileprivate var textField = UITextField()
    fileprivate var viewOne = UIView()
    fileprivate var viewTwo = UIView()
    fileprivate var instructionLabel = UILabel()
    fileprivate var uberLabel = UILabel()
    fileprivate var backButton = UIButton()
    fileprivate let accessoryView = AccessoryView()
    fileprivate var showKeyboard = false
    fileprivate let distance: CGFloat = 32
    fileprivate var labelTopConstraint: NSLayoutConstraint!
    fileprivate var textFieldTopConstraint: NSLayoutConstraint!
    fileprivate var topConstraint: NSLayoutConstraint!
    fileprivate var placeholder = "Enter your mobile number"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewOne()
        setupViewTwo()
        setupUberLabel()
        setupTextField()
        setupBackButton()
        setupLabel()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ViewController {
    
    func setupViewOne() {
        self.view.addSubview(self.viewOne)
        self.view.addSubview(self.viewTwo)
        self.viewOne.backgroundColor = UIColor(netHex: 0x129399)
        self.viewOne.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.viewOne.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.viewOne.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.viewOne.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.viewOne.bottomAnchor.constraint(equalTo: self.viewTwo.topAnchor)
        ])
    }
    
    func setupViewTwo() {
        self.viewTwo.translatesAutoresizingMaskIntoConstraints = false
        
        let leadingConstraint = NSLayoutConstraint(
            item: viewTwo,
            attribute: .leading,
            relatedBy: .equal,
            toItem: view,
            attribute: .leading,
            multiplier: 1.0,
            constant: 0
        )
        let trailingConstraint = NSLayoutConstraint(
            item: viewTwo,
            attribute: .trailing,
            relatedBy: .equal,
            toItem: view,
            attribute: .trailing,
            multiplier: 1.0,
            constant: 0
        )
       
       let bottomConstraint = NSLayoutConstraint(
            item: viewTwo,
            attribute: .bottom,
            relatedBy: .equal,
            toItem: view,
            attribute: .bottom,
            multiplier: 1.0,
            constant: 0.0
        )
        
        topConstraint = NSLayoutConstraint(
            item: viewTwo,
            attribute: .top,
            relatedBy: .equal,
            toItem: view,
            attribute: .bottom,
            multiplier: 1.0,
            constant: -275
        )

        view.addConstraints(
            [leadingConstraint,
             trailingConstraint,
             topConstraint,
             bottomConstraint
            ]
        )
    }
    
    func setupUberLabel() {
        self.uberLabel.text = "Get moving with Uber"
        self.viewTwo.addSubview(self.uberLabel)
        self.uberLabel.font = UIFont(name: "Arial", size: 20)
        self.uberLabel.textColor = UIColor.black
        
        self.uberLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.uberLabel.topAnchor.constraint(equalTo: self.viewTwo.topAnchor, constant: distance + 16 ),
            self.uberLabel.leadingAnchor.constraint(equalTo: self.viewTwo.leadingAnchor, constant: distance)
        ])
    }
    
    func setupTextField() {
        self.viewTwo.addSubview(self.textField)
        self.viewTwo.addSubview(self.backButton)
        
//        let leftView : UILabel = UILabel(frame: CGRect(x: 10, y: 0, width: 7, height: 26))
//        leftView.backgroundColor = UIColor.clear
//        textField.leftView = leftView
//        textField.leftViewMode = .always
//        textField.contentVerticalAlignment = .center
        
        textField.inputAccessoryView = accessoryView
        
        self.textField.placeholder = self.placeholder
        self.textField.autocorrectionType = .no
        self.textField.keyboardType = .phonePad
        self.textField.keyboardAppearance = .dark
        self.textField.delegate = self
        self.textField.translatesAutoresizingMaskIntoConstraints = false
        
        textFieldTopConstraint = NSLayoutConstraint(
            item: textField,
            attribute: .top,
            relatedBy: .equal,
            toItem: backButton,
            attribute: .bottom,
            multiplier: 1.0,
            constant: 16
        )
        
        view.addConstraints(
            [textFieldTopConstraint]
        )
        
        NSLayoutConstraint.activate([
            self.textField.leadingAnchor.constraint(equalTo: self.viewTwo.leadingAnchor, constant: distance ),
            self.textField.trailingAnchor.constraint(equalTo: self.viewTwo.trailingAnchor, constant: -distance),
            self.textField.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func setupBackButton() {
       
        self.backButton.setImage(#imageLiteral(resourceName: "LeftArrow"), for: .normal)
        self.backButton.setTitleColor(UIColor.darkGray, for: .normal)
        self.backButton.alpha = 0
        self.backButton.addTarget(self, action: #selector(backButtonClicked), for: .touchUpInside)
        self.backButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.backButton.topAnchor.constraint(equalTo: self.viewTwo.topAnchor, constant: distance),
//            self.backButton.heightAnchor.constraint(equalToConstant: 40),
            self.backButton.leadingAnchor.constraint(equalTo: self.viewTwo.leadingAnchor, constant: 16)
        ])
    }
    
    func setupLabel() {
        self.instructionLabel.text = self.placeholder
        self.viewTwo.addSubview(self.instructionLabel)
        self.instructionLabel.font = UIFont(name: "Bold", size: 16)
        self.instructionLabel.isHidden = true
        self.instructionLabel.textColor  = UIColor.lightGray
        self.instructionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let leadingConstraint = NSLayoutConstraint(
            item: instructionLabel,
            attribute: .leading,
            relatedBy: .equal,
            toItem: viewTwo,
            attribute: .leading,
            multiplier: 1.0,
            constant: 32
        )
        labelTopConstraint = NSLayoutConstraint(
            item: instructionLabel,
            attribute: .top,
            relatedBy: .equal,
            toItem: backButton,
            attribute: .bottom,
            multiplier: 1.0,
            constant: 0
        )
        
        view.addConstraints(
            [leadingConstraint,
             labelTopConstraint
            ]
        )
    }
    
    func backButtonClicked() {
        showKeyboard = false
        self.textField.resignFirstResponder()
    }
}

extension ViewController: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        self.topConstraint.constant = -self.view.frame.size.height
        self.textFieldTopConstraint.constant = distance*3 - 16
        self.textField.placeholder = "(201) 555-5555"
        setBottomBorder(color: .black)
        self.labelTopConstraint.constant = 32
        self.uberLabel.isHidden = true
        self.instructionLabel.isHidden = false
        UIView.animate(
            withDuration: 0.8,
            delay: 0,
            usingSpringWithDamping: 1,
            initialSpringVelocity: 0.5,
            options: .curveEaseOut,
            animations:
            {
            self.view.layoutIfNeeded()
            }) { _ in
                self.showKeyboard = true
                self.backButton.alpha = 0.8
                self.textField.becomeFirstResponder()
        }
          return showKeyboard
    }
    
    
    func textFieldShouldEndEditing(_ textField: UITextField) ->Bool {
        UIView.animate(
            withDuration: 0.8,
            delay: 0,
            usingSpringWithDamping: 1,
            initialSpringVelocity: 0.5,
            options: .curveEaseOut,
            animations:
            {
            self.topConstraint.constant = -275
            self.backButton.alpha = 0
            self.setBottomBorder(color: .clear)
            self.instructionLabel.isHidden = true
            self.textFieldTopConstraint.constant = 16
            self.textField.placeholder = "Enter mobile number"
            self.uberLabel.isHidden = false
            self.view.layoutIfNeeded()
        })
        
        return true
    }
    
    func textField(
        _ textField: UITextField,
        shouldChangeCharactersIn range: NSRange,
        replacementString string: String
        ) -> Bool
    {
       
        
        guard let text = textField.text else { return true }
        let newLength = text.characters.count + string.characters.count - range.length
        accessoryView.nextButton.isSelected = (newLength > 0)
        accessoryView.nextButton.isEnabled = (newLength > 0)
        if newLength == 0 {
            self.textField.text = ""
        }
        return newLength > 0 ? true : false
    }
}

extension ViewController {
    
    func setBottomBorder(color: UIColor) {
        self.textField.borderStyle = .none
        self.textField.layer.backgroundColor = UIColor.white.cgColor
        
        self.textField.layer.masksToBounds = false
        self.textField.layer.shadowColor = color.cgColor
        self.textField.layer.shadowOffset = CGSize(width: 0.0, height: 1.5)
        self.textField.layer.shadowOpacity = 1.0
        self.textField.layer.shadowRadius = 0.0
    }
}
