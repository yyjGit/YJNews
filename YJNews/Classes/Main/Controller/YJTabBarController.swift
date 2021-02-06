//
//  YJTabBarController.swift
//  YJNews
//
//  Created by yyj on 2021/2/4.
//

import UIKit
import SwiftTheme

class YJTabBarController: UITabBarController {

    
    lazy var itemsInfo: [[String : Any]] = {
        let array = [["vc" : YJHomeViewController(),  "title" : "首页", "imageName" : "home"],
                     ["vc" : YJVideoViewController(), "title" : "视频", "imageName" : "video"],
                     ["vc" : YJHuoShanViewController(), "title" : "小视频", "imageName" : "huoshan"],
                     ["vc" : YJMineViewController(), "title" : "未登录", "imageName" : "no_login"]]
        return array
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // tabbar 字体颜色
        UITabBar.appearance().tintColor = UIColor(red: 245/255.0, green: 90/255.0, blue: 93/255.0, alpha: 1.0)
        // 添加子控器
        addChildControlllers()
        // 添加主题改变通知
        NotificationCenter.default.addObserver(self, selector: #selector(appThemeWillChangeNoti), name: AppThemeWillDidChangeNoti, object: nil)
    }
    
    
    private func addChildControlllers() {
        for dict in itemsInfo {
            addChild(dict["vc"] as! UIViewController, title: dict["title"] as! String, imageNmae: dict["imageName"] as! String)
        }
        // 通过 kvc 重置 tabBar
        setValue(YJTabBar(), forKey: "tabBar")
    }
    
    
    // 添加子控制器
    private func addChild(_ childController: UIViewController, title: String, imageNmae: String) {
        // 设置控制器的 tabBarItem 图片
        updateChildControllerTabBarItemImages(vc: childController, imageName: imageNmae)
                
        // 设置标题、添加
        childController.tabBarItem.title = title
        let naviVc = YJNavigationController(rootViewController: childController)
        self.addChild(naviVc)
    }
    
    
    /// 更新子控制器的 tabBarItem 的图片
    /// - Parameters:
    ///   - vc: 自控制器
    ///   - imageName: 图片名
    private func updateChildControllerTabBarItemImages(vc: UIViewController, imageName: String) {
        let isNight = MYTheme.isNight()
        let normalImageNameSuffix = isNight ? "_tabbar_night_32x32_" : "_tabbar_32x32_"
        let selectImageNameSuffix = isNight ? "_tabbar_press_night_32x32_" : "_tabbar_press_32x32_"

//        vc.tabBarItem.theme_image = ((imageName + normalImageNameSuffix) as! SwiftTheme.ThemeImagePicker)
//        vc.tabBarItem.theme_selectedImage = ((imageName + selectImageNameSuffix) as! SwiftTheme.ThemeImagePicker)

        vc.tabBarItem.image = UIImage(named: imageName + normalImageNameSuffix)
        vc.tabBarItem.selectedImage = UIImage(named: imageName + selectImageNameSuffix)
    }
    
    
    /// 更改主题通知
    @objc private func appThemeWillChangeNoti() {
        for dict in itemsInfo {
            updateChildControllerTabBarItemImages(vc: dict["vc"] as! UIViewController, imageName: dict["imageName"] as! String)
        }
    }
}
