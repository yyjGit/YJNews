//
//  MineNoLoginHeaderView.swift
//  YJNews
//
//  Created by yyj on 2021/2/5.
//

import UIKit
import SwiftTheme

/// 点击事件类型
enum NoLoginHeaderViewActionType: Int {
    case phoneLoginAction = 10
    case wxLoginAction
    case qqLoginAction
    case sinaLoginAction
    case moreLoginAction
    case favoriteAction
    case historyAction
    case nightAction
}

/// 事件回调代理
protocol MineNoLoginHeaderViewDelegate {
    func mineNoLoginHeaderViewButtonAction(_ actiontype: NoLoginHeaderViewActionType)
}

class MineNoLoginHeaderView: UIView {
    
    var delegate: MineNoLoginHeaderViewDelegate?
    static let height: CGFloat = 280
    
    // 创建按钮
    private func createButton(title: String?, imageName: String?, tag: Int, titleColor: UIColor = .black) -> (UIButton) {
        let button = UIButton(type: .custom)
        button.tag = tag
        button.setTitle(title, for: .normal)
        button.addTarget(self, action: #selector(buuttonsAction), for: .touchUpInside)
        button.setTitleColor(titleColor, for: .normal)
        if let imageName = imageName {
            button.setImage(UIImage(named: imageName), for: .normal)
        }
        
        if let _ = imageName, let _ = title {
            button.sizeToFit()
            // 使 image、title 上下居中显示
            button.sizeToFit()
            let imgW: CGFloat = button.imageView!.frame.size.width
            let imgH: CGFloat = button.imageView!.frame.size.height
            let lblW: CGFloat = button.titleLabel!.frame.size.width
            let lblH: CGFloat = button.titleLabel!.frame.size.height
            //设置图片和文字的间距，这里可自行调整
            let margin:CGFloat = 5
            button.imageEdgeInsets = UIEdgeInsets(top: -lblH-margin/2, left: 0, bottom: 0, right: -lblW)
            button.titleEdgeInsets = UIEdgeInsets(top: imgH+margin/2, left: -imgW, bottom: 0, right: 0)
        }
        return button
    }

    
    // MARK: - 属性
    /// 登录按钮
    private lazy var phoneLoginButton: UIButton = {
        return createButton(title: nil, imageName: "cellphoneicon_login_profile_66x66_", tag: 10)
    }()
    private lazy var wxLoginButton: UIButton = {
        return createButton(title: nil, imageName: "weixinicon_login_profile_66x66_", tag: 11)
    }()
    private lazy var qqLoginButton: UIButton = {
        return createButton(title: nil, imageName: "qqicon_login_profile_66x66_", tag: 12)
    }()
    private lazy var sinaLoginButton: UIButton = {
        return createButton(title: nil, imageName: "sinaicon_login_profile_66x66_", tag: 13)
    }()
    private lazy var moreLoginButton: UIButton = {
        let button = createButton(title: "更多登录方式 >", imageName: nil, tag: 14)
        button.backgroundColor = UIColor.black
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 14.0
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    private lazy var loginBtnsBGView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [phoneLoginButton, wxLoginButton, qqLoginButton, sinaLoginButton])
        // 水平布局
        sv.axis = .horizontal
        // 等间距
        sv.distribution = .equalSpacing
        return sv
    }()

    
    /// 收藏、历史、夜间 按钮
    lazy var favoriteButton: UIButton = {
        let button = createButton(title: "收藏", imageName: "favoriteicon_profile_24x24_", tag: 15)
        return button
    }()
    lazy var historyButton: UIButton = {
        let button = createButton(title: "历史", imageName: "history_profile_24x24_", tag: 16)
        return button
    }()
    lazy var nightButton: UIButton = {
        let button = createButton(title: "夜间", imageName: "nighticon_profile_24x24_", tag: 17)
        button.setTitle("白天", for: .selected)
        button.isSelected = MYTheme.isNight()
        return button
    }()
    private lazy var bottomBGView: UIStackView = {
        let stv = UIStackView(arrangedSubviews: [favoriteButton, historyButton, nightButton])
        // 水平布局
        stv.axis = .horizontal
        // 等间距
        stv.distribution = .equalSpacing
        stv.backgroundColor = .white
        return stv
    }()
    
    
    /// 背景图
    var bgImageView: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "wallpaper_profile_night"))
        return iv
    }()
                                
    
    // MARK: - 事件
    @objc func buuttonsAction(button: UIButton) {
        print("tag = \(button.tag)")
        guard let actionType = NoLoginHeaderViewActionType.init(rawValue: button.tag) else { return }
        delegate?.mineNoLoginHeaderViewButtonAction(actionType)
        
        if button.tag == NoLoginHeaderViewActionType.nightAction.rawValue {

            button.isSelected = !button.isSelected
            MYTheme.switchToNight(button.isSelected)
        }
    }
    
      
    // MARK: - 初始化
    class func header() -> MineNoLoginHeaderView {
        let view = MineNoLoginHeaderView.init(frame: CGRect(x: 0, y: 0, width: screenWidth, height: height))
        return view
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(bgImageView)
        
//        let effectX = UIInterpolatingMotionEffect(keyPath: "center.x", type: .tiltAlongHorizontalAxis)
//        effectX.maximumRelativeValue = 20
//        effectX.minimumRelativeValue = -20
//        loginBtnsBGView.addMotionEffect(effectX)
        addSubview(loginBtnsBGView)

        addSubview(bottomBGView)
        addSubview(moreLoginButton)
        bgImageView.frame = self.bounds
        
        phoneLoginButton.theme_setImage("images.loginMobileButton", forState: .normal)
        wxLoginButton.theme_setImage("images.loginWechatButton", forState: .normal)
        qqLoginButton.theme_setImage("images.loginQQButton", forState: .normal)
        sinaLoginButton.theme_setImage("images.loginSinaButton", forState: .normal)
        favoriteButton.theme_setImage("images.mineFavoriteButton", forState: .normal)
        historyButton.theme_setImage("images.mineHistoryButton", forState: .normal)
        nightButton.theme_setImage("images.dayOrNightButton", forState: .normal)
        
        moreLoginButton.theme_backgroundColor = "colors.moreLoginBackgroundColor"
        moreLoginButton.theme_setTitleColor("colors.moreLoginTextColor", forState: .normal)
        favoriteButton.theme_setTitleColor("colors.black", forState: .normal)
        historyButton.theme_setTitleColor("colors.black", forState: .normal)
        nightButton.theme_setTitleColor("colors.black", forState: .normal)
        
        
        bottomBGView.theme_backgroundColor = "colors.cellBackgroundColor"
        
    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - 布局
    override func layoutSubviews() {
        super.layoutSubviews()

        loginBtnsBGView.snp.makeConstraints {
            $0.top.equalTo(50)
            $0.left.equalTo(10)
            $0.right.equalTo(-10)
            $0.height.equalTo(73)
        }
        
        moreLoginButton.snp.makeConstraints {
            $0.centerX.equalTo(self)
            $0.top.equalTo(loginBtnsBGView.snp.bottom).offset(20)
            $0.size.equalTo(CGSize(width: 125, height: 28))
        }
        
        bottomBGView.snp.makeConstraints {
            $0.left.right.bottom.equalTo(0)
            $0.height.equalTo(70)
        }
        favoriteButton.snp.makeConstraints {
            $0.width.equalTo(bottomBGView).multipliedBy(0.33)
        }
        historyButton.snp.makeConstraints {
            $0.width.equalTo(bottomBGView).multipliedBy(0.33)
        }
        nightButton.snp.makeConstraints {
            $0.width.equalTo(bottomBGView).multipliedBy(0.33)
        }
    }
}
