//
//  ViewController.swift
//  PopUpAnimation
//
//  Created by Mac on 09/02/17.
//  Copyright © 2017 Mac. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    fileprivate let textField = UITextField()
    fileprivate let viewOne = UIView()
    fileprivate let viewTwo = UIView()
    fileprivate let instructionLabel = UILabel()
    fileprivate let uberLabel = UILabel()
    fileprivate let backButton = UIButton()
    fileprivate let accessoryView = AccessoryView()
    fileprivate let distance: CGFloat = 32
    fileprivate let placeholder = "Enter your mobile number"
    
    fileprivate var labelTopConstraint: NSLayoutConstraint!
    fileprivate var textFieldTopConstraint: NSLayoutConstraint!
    fileprivate var topConstraint: NSLayoutConstraint!
    fileprivate var showKeyboard = false
    
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
        NSLayoutConstraint.activate([
            self.viewTwo.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.viewTwo.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.viewTwo.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
      
        topConstraint = self.viewTwo.topAnchor.constraint(
            equalTo: self.view.bottomAnchor,
            constant: -self.view.frame.height/3
        )
        topConstraint.isActive = true
    }
    
    func setupUberLabel() {
        self.uberLabel.text = "Get moving with Uber"
        self.viewTwo.addSubview(self.uberLabel)
        self.uberLabel.font = UIFont(name: "Arial", size: 20)
        self.uberLabel.textColor = UIColor.black
        
        self.uberLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.uberLabel.topAnchor.constraint(equalTo: self.viewTwo.topAnchor, constant: distance + distance/2 ),
            self.uberLabel.leadingAnchor.constraint(equalTo: self.viewTwo.leadingAnchor, constant: distance)
        ])
    }
    
    func setupTextField() {
        self.viewTwo.addSubview(self.textField)
        self.viewTwo.addSubview(self.backButton)
        textField.inputAccessoryView = accessoryView
        
        self.textField.placeholder = self.placeholder
        self.textField.autocorrectionType = .no
        self.textField.keyboardType = .phonePad
        self.textField.keyboardAppearance = .dark
        self.textField.delegate = self

        self.textField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.textField.leadingAnchor.constraint(equalTo: self.viewTwo.leadingAnchor, constant: distance ),
            self.textField.trailingAnchor.constraint(equalTo: self.viewTwo.trailingAnchor, constant: -distance),
            self.textField.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        textFieldTopConstraint = self.textField.topAnchor.constraint(
            equalTo: self.backButton.bottomAnchor,
            constant: distance/2
        )
        textFieldTopConstraint.isActive = true
    }
    
    func setupBackButton() {
       
        self.backButton.setImage(#imageLiteral(resourceName: "LeftArrow"), for: .normal)
        self.backButton.setTitleColor(UIColor.darkGray, for: .normal)
        self.backButton.alpha = 0
        self.backButton.addTarget(self, action: #selector(backButtonClicked), for: .touchUpInside)
        self.backButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.backButton.topAnchor.constraint(equalTo: self.viewTwo.topAnchor, constant: distance),
            self.backButton.leadingAnchor.constraint(equalTo: self.viewTwo.leadingAnchor, constant: distance/2)
        ])
    }
    
    func setupLabel() {
        self.instructionLabel.text = self.placeholder
        self.viewTwo.addSubview(self.instructionLabel)
        self.instructionLabel.font = UIFont(name: "Bold", size: distance/2)
        self.instructionLabel.isHidden = true
        self.instructionLabel.textColor  = UIColor.lightGray
        self.instructionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.instructionLabel.leadingAnchor.constraint(
            equalTo: self.viewTwo.leadingAnchor,
            constant: distance
            ).isActive = true
        labelTopConstraint = self.instructionLabel.topAnchor.constraint(equalTo: backButton.bottomAnchor)
        labelTopConstraint.isActive = true
    }
    
    func backButtonClicked() {
        showKeyboard = false
        self.topConstraint.constant = -self.view.frame.height/3
        self.backButton.alpha = 0
        self.setBottomBorder(color: .clear)
        self.instructionLabel.isHidden = true
        self.textFieldTopConstraint.constant = distance/2
        self.textField.placeholder = self.placeholder
        self.uberLabel.isHidden = false
        UIView.animate(
            withDuration: 0.8,
            delay: 0,
            usingSpringWithDamping: 1,
            initialSpringVelocity: 0.5,
            options: .curveEaseOut,
            animations:
            {
                self.view.layoutIfNeeded()
        })

        self.textField.resignFirstResponder()
    }
}

extension ViewController: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        self.topConstraint.constant = -self.view.frame.size.height
        self.textFieldTopConstraint.constant = distance*3 - distance/2
        self.textField.placeholder = "(201) 555-5555"
        setBottomBorder(color: .black)
        self.labelTopConstraint.constant = distance
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
        return newLength <= 10 ? true : false
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
