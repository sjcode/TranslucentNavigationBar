//
//  UIImage+color.swift
//  TranslucentNavigationBar
//
//  Created by sujian on 2017/1/18.
//  Copyright © 2017年 sujian. All rights reserved.
//

import UIKit

extension UIImage {
    class func image(color: UIColor) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.fill(rect)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image!
    }
}
