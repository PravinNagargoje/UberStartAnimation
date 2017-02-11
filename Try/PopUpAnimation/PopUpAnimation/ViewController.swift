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
    fileprivate var backButton = UIButton()
    fileprivate var topConstraint: NSLayoutConstraint!
    fileprivate var showKeyboard = false
    fileprivate var nextButton = UIButton()
    fileprivate let distance: CGFloat = 32
    fileprivate var nextButtonBottomConstraint: NSLayoutConstraint!
    fileprivate var labelTopConstraint: NSLayoutConstraint!
    fileprivate var textFieldTopConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewOne()
        setupViewTwo()
        setupTextField()
        setupButton()
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
        self.viewOne.backgroundColor = UIColor.gray
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
    
    func setupTextField() {
       
        self.viewTwo.addSubview(self.textField)
        self.viewTwo.addSubview(self.backButton)
        
        let leftView : UILabel = UILabel(frame: CGRect(x: 10, y: 0, width: 7, height: 26))
        leftView.backgroundColor = UIColor.clear
        
        textField.inputAccessoryView = AccessoryView()
        
        
        textField.leftView = leftView
        textField.leftViewMode = .always
        textField.contentVerticalAlignment = .center
        
        self.textField.placeholder = "Enter mobile number"
        self.textField.layer.borderWidth = 1
        self.textField.layer.cornerRadius = 7
        self.textField.autocorrectionType = .no
        self.textField.keyboardType = .phonePad
        self.textField.keyboardAppearance = .dark
        self.textField.delegate = self
        self.textField.layer.borderColor = UIColor.darkGray.cgColor
        self.textField.translatesAutoresizingMaskIntoConstraints = false
        
        textFieldTopConstraint = NSLayoutConstraint(
            item: textField,
            attribute: .top,
            relatedBy: .equal,
            toItem: backButton,
            attribute: .top,
            multiplier: 1.0,
            constant: 0
        )
        
        view.addConstraints(
            [textFieldTopConstraint]
        )
        
        NSLayoutConstraint.activate([
            self.textField.leadingAnchor.constraint(equalTo: self.viewTwo.leadingAnchor, constant: distance + 32),
            self.textField.trailingAnchor.constraint(equalTo: self.viewTwo.trailingAnchor, constant: -distance),
            self.textField.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func setupButton() {
       
        self.backButton.setTitle("Back", for: .normal)
        self.backButton.setTitleColor(UIColor.darkGray, for: .normal)
        self.backButton.alpha = 0
        self.backButton.addTarget(self, action: #selector(backButtonClicked), for: .touchUpInside)
        self.backButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.backButton.topAnchor.constraint(equalTo: self.viewTwo.topAnchor, constant: distance),
            self.backButton.heightAnchor.constraint(equalToConstant: 40),
            self.backButton.leadingAnchor.constraint(equalTo: self.viewTwo.leadingAnchor, constant: 16)
        ])
    }
    
    func setupLabel() {
        self.instructionLabel.text = "Enter mobile number"
        self.viewTwo.addSubview(self.instructionLabel)
        self.instructionLabel.font = UIFont(name: "Bold", size: 16)
        self.instructionLabel.isHidden = true
        self.instructionLabel.textColor  = UIColor.lightGray
        self.instructionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let leadingConstraint = NSLayoutConstraint(
            item: instructionLabel,
            attribute: .leading,
            relatedBy: .equal,
            toItem: backButton,
            attribute: .trailing,
            multiplier: 1.0,
            constant: 12
        )
        labelTopConstraint = NSLayoutConstraint(
            item: instructionLabel,
            attribute: .top,
            relatedBy: .equal,
            toItem: backButton,
            attribute: .top,
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
        self.textFieldTopConstraint.constant = 80
        self.textField.placeholder = ""
        self.labelTopConstraint.constant = 40
        self.instructionLabel.isHidden = false
        UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
            self.view.layoutIfNeeded()
            }) { _ in
                self.showKeyboard = true
                self.backButton.alpha = 0.8
                self.textField.becomeFirstResponder()
        }
          return showKeyboard
    }
    
    
    func textFieldShouldEndEditing(_ textField: UITextField) ->Bool {
        UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
            self.topConstraint.constant = -275
            self.backButton.alpha = 0
            self.instructionLabel.isHidden = true
            self.textFieldTopConstraint.constant = 0
            self.textField.placeholder = "Enter mobile number"
            
            self.view.layoutIfNeeded()
        })
        
        return true
    }
}

// Mark: - For iOS 10 and further only
//    var constraint: UIViewPropertyAnimator?
//extension ViewController: UITextFieldDelegate {
//    
//    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
//                constraint = UIViewPropertyAnimator(duration: 1, dampingRatio: 1.5, animations: {
//        
//                    self.topConstraint.constant = -self.view.frame.size.height
//                    self.textFieldTopConstraint.constant = 80
//                    self.textField.placeholder = ""
//                    self.labelTopConstraint.constant = 40
//                    self.instructionLabel.isHidden = false
//                    self.view.layoutIfNeeded()
//                })
//        
//                constraint?.startAnimation()
//                constraint?.addCompletion {
//                    _ in
//                        self.showKeyboard = true
//                        self.backButton.isHidden = false
//                        self.textField.becomeFirstResponder()
//                }
//            return showKeyboard
//    }
//    
//    func textFieldShouldEndEditing(_ textField: UITextField) ->Bool {
//        
//                constraint = UIViewPropertyAnimator(duration: 1, dampingRatio: 1.5, animations: {
//        
//                    self.topConstraint.constant = -275
//                    self.backButton.isHidden = true
//                    self.instructionLabel.isHidden = true
//                    self.textFieldTopConstraint.constant = 0
//                    self.textField.placeholder = "Enter mobile number"
//        
//                    self.view.layoutIfNeeded()
//                })
//                constraint?.startAnimation()
//        return true
//    }
//}
