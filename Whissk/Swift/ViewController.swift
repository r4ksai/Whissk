//
//  ViewController.swift
//  Whissk
//
//  Created by Sai Madhav on 21/08/18.
//  Copyright © 2018 Sai Madhav. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    //MARK:- Variable Declaration
    @IBOutlet weak var slideShow: UIImageView!
    
    //TODO:- Start the slidehsow using a time loop
    override func viewDidAppear(_ animated: Bool) {
        //Start Slideshow
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
        
    }
    
    //MARK:- LogIn Button
    @IBAction func logIn(_ sender: Any) {
        performSegue(withIdentifier: "logInSeg", sender: self)
    }
    
}
