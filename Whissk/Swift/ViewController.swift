//
//  ViewController.swift
//  Whissk
//
//  Created by Sai Madhav on 21/08/18.
//  Copyright © 2018 Sai Madhav. All rights reserved.
//

import UIKit

class HomeController: UIViewController {
    
    //MARK:- Variable Declaration
    @IBOutlet weak var slideShow: UIImageView!
    
    //{} is referred to as closure or anon. functions
    let slideImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.yellow
        //This enables autolayout for our imageView
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let getLocationButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("SET DELIVERY LOCATION", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = UIColor.blue
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let t1 : UITextView = {
        let textBar = UITextView()
        //let attributedText = NSMutableAttributedString(string: "Now your secret ingredient", attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 20)])
        //textBar.attributedText = attributedText
        textBar.text = "Now your secret \ningredient"
        textBar.font = UIFont.boldSystemFont(ofSize: 20)
        textBar.textAlignment = NSTextAlignment.center
        textBar.isScrollEnabled = false
        textBar.isEditable = false
        textBar.translatesAutoresizingMaskIntoConstraints = false
        return textBar
    }()
    
    
    let t2 : UILabel = {
        let textBar = UILabel()
        textBar.text = "Welcome your box of ingredients."
        textBar.font = UIFont.boldSystemFont(ofSize: 13)
        textBar.textAlignment = .center
        textBar.translatesAutoresizingMaskIntoConstraints = false
        return textBar
    }()
    
    private let loginButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Login", for: .normal)
        button.setTitleColor(UIColor.red, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let t3 : UILabel = {
        let textBar = UILabel()
        textBar.text = "Have an account ?"
        textBar.textAlignment = .right
        textBar.translatesAutoresizingMaskIntoConstraints = false
        return textBar
    }()
    
    let slideControl : UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.numberOfPages = 3
        pageControl.currentPageIndicatorTintColor = UIColor.blue
        pageControl.pageIndicatorTintColor = UIColor.gray
        pageControl.currentPage = 0
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        return pageControl
    }()
    
    let bottomContainer : UIView = {
        let bottomView = UIView()
        bottomView.backgroundColor = UIColor.white
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        return bottomView
    }()
    
    let logInContainer : UIView = {
        let logInView = UIView()
        logInView.backgroundColor = UIColor.init(hue: 0, saturation: 0, brightness: 0, alpha: 0)
        logInView.translatesAutoresizingMaskIntoConstraints = false
        return logInView
    }()
    
    //TODO:- Start the slidehsow using a time loop
    override func viewDidAppear(_ animated: Bool) {
        //Start Slideshow
    }
    
    
    override func viewDidLoad() {
        view.backgroundColor = UIColor.red
        
        setUpSubviews()
        setUpLayout()
    }
    
    fileprivate func setUpSubviews(){
        view.addSubview(slideImageView)
        view.addSubview(bottomContainer)
        bottomContainer.addSubview(getLocationButton)
        bottomContainer.addSubview(t1)
        bottomContainer.addSubview(slideControl)
        bottomContainer.addSubview(t2)
        bottomContainer.addSubview(logInContainer)
        logInContainer.addSubview(t3)
        logInContainer.addSubview(loginButton)
    }
    
    private func setUpLayout(){
        NSLayoutConstraint.activate([
        slideImageView.topAnchor.constraint(equalTo: view.topAnchor, constant:0),
        slideImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
        slideImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        slideImageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.60),
        
        bottomContainer.topAnchor.constraint(equalTo: slideImageView.bottomAnchor, constant: 0),
        bottomContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
        bottomContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        bottomContainer.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        
        t1.centerXAnchor.constraint(equalTo: bottomContainer.centerXAnchor),
        t1.topAnchor.constraint(equalTo: bottomContainer.topAnchor, constant:20),
        t1.widthAnchor.constraint(equalTo: bottomContainer.widthAnchor, multiplier: 0.75),
        t1.heightAnchor.constraint(equalToConstant: 70),

        slideControl.centerXAnchor.constraint(equalTo: bottomContainer.centerXAnchor),
        slideControl.topAnchor.constraint(equalTo: t1.bottomAnchor, constant: 10),
        slideControl.widthAnchor.constraint(equalTo: bottomContainer.widthAnchor, multiplier: 0.75),
        slideControl.heightAnchor.constraint(equalToConstant: 30),
        
        t2.centerXAnchor.constraint(equalTo: bottomContainer.centerXAnchor),
        t2.topAnchor.constraint(equalTo: slideControl.bottomAnchor, constant: 10 ),
        t2.widthAnchor.constraint(equalTo: bottomContainer.widthAnchor, multiplier: 0.75),
        t2.heightAnchor.constraint(equalToConstant: 20),
        
        getLocationButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        getLocationButton.topAnchor.constraint(equalTo: t2.bottomAnchor, constant: 10),
        getLocationButton.widthAnchor.constraint(equalTo: bottomContainer.widthAnchor, multiplier: 0.75),
        getLocationButton.heightAnchor.constraint(equalToConstant: 42),
        
        logInContainer.centerXAnchor.constraint(equalTo: bottomContainer.centerXAnchor),
        loginButton.topAnchor.constraint(equalTo: getLocationButton.bottomAnchor, constant: 10),
        logInContainer.widthAnchor.constraint(equalTo: bottomContainer.widthAnchor, multiplier: 0.75),
        logInContainer.heightAnchor.constraint(equalToConstant: 30),
        
        t3.centerYAnchor.constraint(equalTo: logInContainer.centerYAnchor),
        t3.leadingAnchor.constraint(equalTo: logInContainer.leadingAnchor),
        t3.widthAnchor.constraint(equalTo: logInContainer.widthAnchor, multiplier: 0.8),
        t3.heightAnchor.constraint(equalToConstant: 30),
        
        loginButton.centerYAnchor.constraint(equalTo: logInContainer.centerYAnchor),
        loginButton.leadingAnchor.constraint(equalTo: t3.trailingAnchor),
        loginButton.widthAnchor.constraint(equalTo: logInContainer.widthAnchor, multiplier: 0.2),
        loginButton.heightAnchor.constraint(equalToConstant: 30),
        
        ])

    }
    
    
    //MARK:- Change the Status bar to white
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    //MARK:- Slide Show Controls
    @IBAction func slideShowControl(_ sender: UIPageControl) {
        if sender.currentPage == 0 {
            //Change the image
        }
        else if sender.currentPage == 1 {
            //Change the image
        }
            else if sender.currentPage == 2 {
                //Change the image
            }
            else
        {
         //Error
        }
        
    }
    
    //MARK:- Delivery Location Button
    @IBAction func deliveryLocation(_ sender: Any) {
        performSegue(withIdentifier: "pickLocation", sender: self)
    }
    
    //MARK:- LogIn Button
    @IBAction func logIn(_ sender: Any) {
        performSegue(withIdentifier: "logInSeg", sender: self)
    }

    
    
    
    
}
