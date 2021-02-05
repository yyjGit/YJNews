//
//  UIColor+Extensions.swift
//  YJNews
//
//  Created by yyj on 2021/2/4.
//

import UIKit

extension UIColor {

    convenience init(r: CGFloat, g: CGFloat, b: CGFloat, alpha: CGFloat = 1.0) {
        self.init(displayP3Red: r/255.0, green: g/255.0, blue: b/255/0, alpha: alpha)
    }
        
    // 默认背景色
    static let defaultBackgroundColor = UIColor(r: 248, g: 249, b: 247)
    
}
