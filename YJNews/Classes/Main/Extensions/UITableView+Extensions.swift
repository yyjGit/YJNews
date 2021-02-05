//
//  UITableView+Extensions.swift
//  YJNews
//
//  Created by yyj on 2021/2/5.
//

import UIKit

extension UITableView {
        
    /// 注册 cell 方法
    /**
     * <T: UITableViewCell>：这里 T 是泛型，且 T 必须是 UITableViewCell 的子类
     * T.Type：是一种类型，T.self 是 T.Type 类型，也就是说这里 cell 要传的是：CustomCell.self
     * where T: RegisterCellOrNib：表示 T 需要遵守 RegisterCellOrNib 协议
     */
    func yj_registerCell<T: UITableViewCell>(cell : T.Type) where T: RegisterCellOrNib {        
//        if let nib = T.nib {
//            register(nib, forCellReuseIdentifier: T.idendifier)
//        } else {
            register(T.self, forCellReuseIdentifier: T.idendifier)
//        }
    }
    
    /// 从缓存池，出队已经存在的 celll
    func yj_dequeueReusableCell<T: UITableViewCell>(indexPath: IndexPath) -> T where T: RegisterCellOrNib {
        return dequeueReusableCell(withIdentifier: T.idendifier, for: indexPath) as! T
    }
}
