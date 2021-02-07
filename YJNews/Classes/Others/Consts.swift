//
//  Consts.swift
//  YJNews
//
//  Created by yyj on 2021/2/4.
//

import UIKit

// MARK: - 常用尺寸
let screenWidth = UIScreen.main.bounds.width
let screenHeight = UIScreen.main.bounds.height

let is_iPhoneX = screenWidth >= 375.0 && screenHeight >= 812.0 && UI_USER_INTERFACE_IDIOM() == .phone
let tabbarHeight: CGFloat = is_iPhoneX ? 83.0 : 49
let statusBarHeight = UIApplication.shared.statusBarFrame.height
let navigationBarHeight = 44 + statusBarHeight
let HasNaviBarBounds = CGRect(x: 0, y:navigationBarHeight , width: screenWidth, height: screenHeight - navigationBarHeight)


// MARK: - 接口参数
let BASE_URL = "https://is.snssdk.com"
let device_id: String = "6096495334"
let IID: String = "5034850950"

let isNightMode = "isNightMode"


// MARK: - 通知名
/// 主题将要改变（白天、夜间切换）
let AppThemeWillDidChangeNoti = Notification.Name(rawValue: "AppThemeWillDidChangeNoti")


