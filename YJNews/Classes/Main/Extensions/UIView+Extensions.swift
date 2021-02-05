//
//  UIView+Extensions.swift
//  YJNews
//
//  Created by yyj on 2021/2/5.
//

import UIKit

protocol RegisterCellOrNib { }


extension RegisterCellOrNib {
    /// cell 标识符
    static var idendifier: String {
        return String(describing: self)
    }
    
    /// 可选值，有 则从nib 加载 cell
//    static var nib: UINib? {
//        let nib  = UINib(nibName: String(describing: self), bundle: nil)
//        return nib
//    }
}
