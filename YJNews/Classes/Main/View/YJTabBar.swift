//
//  YJTabBar.swift
//  YJNews
//
//  Created by yyj on 2021/2/4.
//

import UIKit

class YJTabBar: UITabBar {

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(publishButton)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // private: 绝对私有，仅在当前当前文件、当前类中能访
    // fileprivate: 文件私有，仅在当前文件中访问
    // internal: 默认的，不用写
    // open: 在任何文件中都能访问
    private lazy var publishButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setBackgroundImage(UIImage(named: "feed_publish_44x44_"), for: .normal)
        button.setBackgroundImage(UIImage(named: "feed_publish_press_44x44_"), for: .selected)
        button.sizeToFit()
        return button
    }()
    
    
    // 重新布局
    override func layoutSubviews() {
        super.layoutSubviews()        
        // 获取 self 的 宽高
        let width = frame.width
        let height = frame.height
        publishButton.center = CGPoint(x: width * 0.5, y: height * 0.5 - 1)
        
        // 重置其它按钮 frame
        let buttonW: CGFloat = width * 0.2
        var buttonX: CGFloat = 0.0
        var index = 0
        for button in subviews {
            if !button.isKind(of: NSClassFromString("UITabBarButton")!) { continue }
            buttonX = buttonW * CGFloat((index > 1 ? (index+1) : index))
            button.frame = CGRect(x: buttonX, y: 0, width: buttonW, height: height)
            index += 1
        }
    }
}

