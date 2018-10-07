//
//  CleanCodeManager.swift
//  Whissk
//
//  Created by Sai Madhav on 27/09/18.
//  Copyright © 2018 Sai Madhav. All rights reserved.
//

import UIKit

class MoreDetailsController: NSObject {
    let blackView = UIView()
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return cv
    }()
    func standby(){
        //Slide up Details if adress success
        if let window = UIApplication.shared.keyWindow{
        blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(exitMoreDetails))
        swipeDown.direction = UISwipeGestureRecognizer.Direction.down
        blackView.addGestureRecognizer(swipeDown)
        
        window.addSubview(blackView)
        window.addSubview(collectionView)
        
        let height : CGFloat = 200
        let y = window.frame.height - height
        collectionView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: height)
        
        blackView.frame = window.frame
        blackView.alpha = 0
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.blackView.alpha = 1
            
            self.collectionView.frame = CGRect(x: 0, y: y, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
        }, completion: nil)
        }
    }
    
    @objc func exitMoreDetails(){
        //Makes the black view invisible
        UIView.animate(withDuration: 0.5) {
            self.blackView.alpha = 0
            
            if let window = UIApplication.shared.keyWindow{
            self.collectionView.frame = CGRect(x: 0, y: window.frame.height, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
            }
                        }
    }
    override init() {
        super.init()
    }
    
}
