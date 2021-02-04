//
//  YJTabBarController.swift
//  YJNews
//
//  Created by yyj on 2021/2/4.
//

import UIKit

class YJTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // tabbar 字体颜色
        UITabBar.appearance().tintColor = UIColor(red: 245/255.0, green: 90/255.0, blue: 93/255.0, alpha: 1.0)
        // 添加子控器
        addChildControlllers()
    }
    
    func addChildControlllers() {
        addChild(YJHomeViewController(), title: "首页", imageNmae: "home_tabbar_32x32_", selectedImageName: "home_tabbar_press_32x32_")
        addChild(YJVideoViewController(), title: "视频", imageNmae: "video_tabbar_32x32_", selectedImageName: "video_tabbar_press_32x32_")
        addChild(YJHuoShanViewController(), title: "小视频", imageNmae: "huoshan_tabbar_32x32_", selectedImageName: "huoshan_tabbar_press_32x32_")
        addChild(YJMineViewController(), title: "我的", imageNmae: "mine_tabbar_32x32_", selectedImageName: "mine_tabbar_press_32x32_")
        
        // 通过 kvc 重置 tabBar
        setValue(YJTabBar(), forKey: "tabBar")
    }
    
    // 添加子控制器
    func addChild(_ childController: UIViewController, title: String, imageNmae: String, selectedImageName: String) {

        childController.tabBarItem.image = UIImage(named: imageNmae)
        childController.tabBarItem.selectedImage = UIImage(named: selectedImageName)
        childController.tabBarItem.title = title
        
        let naviVc = YJNavigationController(rootViewController: childController)
        self.addChild(naviVc)
    }

}
