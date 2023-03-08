//
//  UIcolor + Ext.swift
//  testReaction
//
//  Created by Андрушок on 14.12.2022.
//

import UIKit

extension UIColor {
    
    static func getRandomColor() -> UIColor {
         let red:CGFloat = CGFloat(drand48())
         let green:CGFloat = CGFloat(drand48())
         let blue:CGFloat = CGFloat(drand48())

         return UIColor(red:red, green: green, blue: blue, alpha: 1.0)
    }
}

protocol BackGroundImageDelegate: AnyObject {
    func changeBackGround(image: UIImage)
}

extension StartViewController: BackGroundImageDelegate {
    func changeBackGround(image: UIImage) {
        self.imageView.image = image
    }
}

protocol AlertViewControllerDelegate: AnyObject {
    func restartGame()
    func closeInfo()
}

extension ViewController: AlertViewControllerDelegate {
    func restartGame() {
        countTouches = 0
        startGameTime = Date()
        setupGameButton()
    }
    
    func closeInfo() {
        
    }
}


