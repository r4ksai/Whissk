//
//  TypeAddress.swift
//  Whissk
//
//  Created by Sai Madhav on 22/08/18.
//  Copyright © 2018 Sai Madhav. All rights reserved.
//

import UIKit
import GooglePlaces


class TypeAddress: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let autocompleteController = GMSAutocompleteViewController()
        //autocompleteController.delegate = self
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
