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
    fileprivate var backButton = UIButton()
    fileprivate var topConstraint: NSLayoutConstraint!
    let distance: CGFloat = 32
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: NSNotification.Name.UIKeyboardWillShow,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector:  #selector(keyboardWillHide),
            name: NSNotification.Name.UIKeyboardWillHide,
            object: nil
        )

        
        setupViewOne()
        setupViewTwo()
        setupTextField()
        setupButton()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
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

    func keyboardWillShow(notification: NSNotification) {
        if let userInfo = notification.userInfo {
            self.backButton.isHidden = false
            let info = notification.userInfo!
            let duration:Double = info[UIKeyboardAnimationDurationUserInfoKey] as! Double
            if let _: CGRect = (
                userInfo[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
                topConstraint.constant = -self.view.frame.size.height
                UIView.animate(withDuration: duration) {
                    self.view.layoutIfNeeded()
                }
            }
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        topConstraint.constant = -275
        self.backButton.isHidden = true
        let info = notification.userInfo!
        let duration:Double = info[UIKeyboardAnimationDurationUserInfoKey] as! Double
        UIView.animate(withDuration: duration) {
            self.view.layoutIfNeeded()
        }
    }

    
    func setupTextField() {
       
        self.viewTwo.addSubview(self.textField)
        self.viewTwo.addSubview(self.backButton)
        self.textField.placeholder = "enter number"
        self.textField.layer.borderWidth = 1
        self.textField.autocorrectionType = .no
        self.textField.layer.borderColor = UIColor.red.cgColor
        self.textField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.textField.topAnchor.constraint(equalTo: self.viewTwo.topAnchor, constant: distance),
            self.textField.leadingAnchor.constraint(equalTo: self.viewTwo.leadingAnchor, constant: distance + 32),
            self.textField.trailingAnchor.constraint(equalTo: self.viewTwo.trailingAnchor, constant: -distance),
            self.textField.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func setupButton() {
       
        self.backButton.setTitle("Back", for: .normal)
        self.backButton.setTitleColor(UIColor.blue, for: .normal)
        self.backButton.isHidden = true
        self.backButton.addTarget(self, action: #selector(backButtonClicked), for: .touchUpInside)
        self.backButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.backButton.topAnchor.constraint(equalTo: self.textField.topAnchor),
            self.backButton.bottomAnchor.constraint(equalTo: self.textField.bottomAnchor),
            self.backButton.leadingAnchor.constraint(equalTo: self.viewTwo.leadingAnchor, constant: 16)
        ])
    }
    
    func backButtonClicked() {
        self.textField.resignFirstResponder()
    }
}
