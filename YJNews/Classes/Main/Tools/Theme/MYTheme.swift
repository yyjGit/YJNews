//
//  MYTheme.swift
//  YJNews
//
//  Created by yyj on 2021/2/5.
//

import Foundation

import SwiftTheme


enum MYTheme: Int {
    case day
    case night
    
    static var before = MYTheme.day
    static var current = MYTheme.day
    
    /// 切换主题
    /// - Parameter isToNight: true:夜晚 false:白天
    static func switchToNight(_ isToNight: Bool) {
        UserDefaults.standard.set(isToNight, forKey: isNightMode)
        switchTo(isToNight ? .night : .day)
    }
            
    /// 是否是夜晚主题
    /// - Returns: 是否是夜晚
    static func isNight() -> Bool {
        return UserDefaults.standard.bool(forKey: isNightMode)
    }
    
    /// 选择主题
    /// - Parameter theme: 要展示的主题
    private static func switchTo(_ theme: MYTheme) {
        before = current
        current = theme
        
        switch theme {
            case .day: ThemeManager.setTheme(plistName: "default_theme", path: .mainBundle)
            case .night: ThemeManager.setTheme(plistName: "night_theme", path: .mainBundle)
        }
    }
}



