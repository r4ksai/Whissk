//
//  ViewController.swift
//  Whissk
//
//  Created by Sai Madhav on 21/08/18.
//  Copyright © 2018 Sai Madhav. All rights reserved.
//Create a lot of global variables for holding color and everything
//Do the Layout
import UIKit

class HomeController: UIViewController {
    
    //MARK:- Variable Declaration
    var textButtonDist : CGFloat = 40
    
    //{} is referred to as closure or anon. functions
    //Creates an imageView
    let slideImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.yellow
        //This enables autolayout for our imageView
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    //Creates a Button
    private let getLocationButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("SET DELIVERY LOCATION", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = UIColor.blue
        button.addTarget(self, action: #selector(deliveryLocation), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    //Creates a textView
    let t1 : UITextView = {
        let textBar = UITextView()
        textBar.text = "Now your secret \ningredient"
        textBar.font = UIFont.boldSystemFont(ofSize: 22)
        textBar.textAlignment = NSTextAlignment.center
        textBar.isScrollEnabled = false
        textBar.isEditable = false
        textBar.translatesAutoresizingMaskIntoConstraints = false
        return textBar
    }()
    
    //Creates a UILabel
    let t2 : UILabel = {
        let textBar = UILabel()
        textBar.text = "Welcome your box of ingredients."
        textBar.font = UIFont.boldSystemFont(ofSize: 13)
        textBar.textAlignment = .center
        textBar.translatesAutoresizingMaskIntoConstraints = false
        return textBar
    }()
    
    //Creates a Button for login
    private let loginButton : UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Login", for: .normal)
        button.setTitleColor(UIColor.red, for: .normal)
        button.contentHorizontalAlignment = .left
        button.addTarget(self, action: #selector(logIn), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    //Creates a UILabel
    let t3 : UILabel = {
        let textBar = UILabel()
        textBar.text = "Have an account ?"
        textBar.textAlignment = .right
        textBar.translatesAutoresizingMaskIntoConstraints = false
        return textBar
    }()
    
    //Creates a View to contain two more views with a height ratio
    let bottomContainer : UIView = {
        let bottomView = UIView()
        bottomView.backgroundColor = UIColor.white
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        return bottomView
    }()
    
    //Creates a View to put the heading title
    let bottom1Container : UIView =
    {
        let bottomView = UIView()
        bottomView.backgroundColor = UIColor.init(hue: 0, saturation: 0, brightness: 0, alpha: 0)
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        return bottomView
    }()
    
    //Creates a View to put the texts and the buttons together
    let bottom2Container : UIView = {
        let bottomView = UIView()
        bottomView.backgroundColor = UIColor.init(hue: 0, saturation: 0, brightness: 0, alpha: 0)
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        return bottomView
    }()
    
    //Creates a View to put the login and the text together
    let logInContainer : UIView = {
        let logInView = UIView()
        logInView.backgroundColor = UIColor.init(hue: 0, saturation: 0, brightness: 0, alpha: 0)
        logInView.translatesAutoresizingMaskIntoConstraints = false
        return logInView
    }()
    
    
    //Calls when the view appears
    override func viewDidAppear(_ animated: Bool) {
        //Starts a timer and calls slideshow() function after every 10 seconds
        Timer.scheduledTimer(timeInterval: 10, target: self, selector: (#selector(slideShow)), userInfo: nil, repeats: true)
    }
    
    //Calls when the view gets loaded
    override func viewDidLoad() {
        //Sets the background colour as white
        view.backgroundColor = UIColor.white
        //Calls the function to set up subviews
        setUpSubviews()
        //Calls the function to set up the layout of the Views
        setUpLayout()
        
    }
    
    //MARK:- Slideshow
    @objc func slideShow(){
        //the timer counts till 10 secs and executes this function
    }
    
    //MARK:- Change the Status bar to white
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    //MARK:- Delivery Location Button
    @objc func deliveryLocation(sender: UIButton) {
        performSegue(withIdentifier: "pickLocation", sender: self)
    }
    
    //MARK:- LogIn Button
    @objc func logIn(sender: UIButton) {
        performSegue(withIdentifier: "logInSeg", sender: self)
    }
    
    //MARK:- Add Subviews
    fileprivate func setUpSubviews(){
        view.addSubview(slideImageView)
        view.addSubview(bottomContainer)
        bottomContainer.addSubview(bottom1Container)
        bottomContainer.addSubview(bottom2Container)
        bottom1Container.addSubview(t1)
        bottom2Container.addSubview(t2)
        bottom2Container.addSubview(getLocationButton)
        bottom2Container.addSubview(logInContainer)
        logInContainer.addSubview(t3)
        logInContainer.addSubview(loginButton)
    }
    
    private func setUpLayout(){
        
        let screenHeight = view.bounds.height //Stores the screen height in a variable
        if screenHeight > 800{
            textButtonDist = 60 //Changes the value if the screen height is more than 700 i.e. X models
        }
        else if screenHeight > 700
        {
            textButtonDist = 50 //Changes the value if the screen height is more than 700 i.e. Plus models
        }
        else if screenHeight > 600
        {
            textButtonDist = 40//Changes the value if the screen height is more than 700 i.e. 6,7,8 models
        }
        else {
            textButtonDist = 20//Changes the value if the screen height is more than 700 i.e. 5s model
        }
        
        
        NSLayoutConstraint.activate([
        slideImageView.topAnchor.constraint(equalTo: view.topAnchor, constant:0),
        slideImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
        slideImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        slideImageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.60),
        
        bottomContainer.topAnchor.constraint(equalTo: slideImageView.bottomAnchor, constant: 0),
        bottomContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
        bottomContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        bottomContainer.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        
        bottom1Container.topAnchor.constraint(equalTo: bottomContainer.topAnchor, constant: 0),
        bottom1Container.leadingAnchor.constraint(equalTo: view.leadingAnchor),
        bottom1Container.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        bottom1Container.heightAnchor.constraint(equalTo: bottomContainer.heightAnchor, multiplier: 0.30),
        
        bottom2Container.heightAnchor.constraint(equalTo: bottomContainer.heightAnchor, multiplier: 0.70),
        bottom2Container.leadingAnchor.constraint(equalTo: view.leadingAnchor),
        bottom2Container.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        bottom2Container.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        
        t1.centerXAnchor.constraint(equalTo: bottom1Container.centerXAnchor),
        t1.centerYAnchor.constraint(equalTo: bottom1Container.centerYAnchor, constant:0),
        t1.widthAnchor.constraint(equalTo: bottom1Container.widthAnchor, multiplier: 0.75),
        t1.heightAnchor.constraint(equalToConstant: 70),

        t2.centerXAnchor.constraint(equalTo: bottom2Container.centerXAnchor),
        t2.topAnchor.constraint(equalTo: bottom2Container.topAnchor, constant: textButtonDist),
        t2.widthAnchor.constraint(equalTo: bottom2Container.widthAnchor, multiplier: 0.75),
        t2.heightAnchor.constraint(equalToConstant: 30),
        
        getLocationButton.centerXAnchor.constraint(equalTo: bottom2Container.centerXAnchor),
        getLocationButton.centerYAnchor.constraint(equalTo: bottom2Container.centerYAnchor),
        getLocationButton.widthAnchor.constraint(equalTo: bottom2Container.widthAnchor, multiplier: 0.75),
        getLocationButton.heightAnchor.constraint(equalToConstant: 42),
        
        logInContainer.centerXAnchor.constraint(equalTo: bottom2Container.centerXAnchor),
        logInContainer.bottomAnchor.constraint(equalTo: bottom2Container.bottomAnchor, constant:-textButtonDist),
        logInContainer.widthAnchor.constraint(equalTo: bottom2Container.widthAnchor, multiplier: 0.75),
        logInContainer.heightAnchor.constraint(equalToConstant: 30),
        
        t3.centerYAnchor.constraint(equalTo: logInContainer.centerYAnchor),
        t3.leadingAnchor.constraint(equalTo: logInContainer.leadingAnchor),
        t3.widthAnchor.constraint(equalTo: logInContainer.widthAnchor, multiplier: 0.7),
        t3.heightAnchor.constraint(equalToConstant: 30),
        
        loginButton.centerYAnchor.constraint(equalTo: logInContainer.centerYAnchor),
        loginButton.leadingAnchor.constraint(equalTo: t3.trailingAnchor),
        loginButton.widthAnchor.constraint(equalTo: logInContainer.widthAnchor, multiplier: 0.3),
        loginButton.heightAnchor.constraint(equalToConstant: 30)

        ])

    }
    


    
}
